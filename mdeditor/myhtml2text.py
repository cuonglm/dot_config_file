import html2text
#import re


def google_text_emphasis(style):
        """return a list of all emphasis modifiers of the element"""
        emphasis = []
        if 'text-decoration' in style:
            for decor in style['text-decoration'].split(' '):
                emphasis.append(decor)
        if 'font-style' in style:
            emphasis.append(style['font-style'])
        if 'font-weight' in style:
            emphasis.append(style['font-weight'])
            if int(style['font-weight']) >= 600:
                emphasis.append('bold')
        return emphasis
html2text.google_text_emphasis = google_text_emphasis


def google_fixed_width_font(style):
    """check if the css of the current element defines a fixed width font"""
    font_family = ''
    if 'font-family' in style:
        font_family = style['font-family']
    if 'Courier New' in font_family or 'Consolas' in font_family:
        return True
    return False
html2text.google_fixed_width_font = google_fixed_width_font


def hn(ts, ps):
    """check header
    ts: tag_style
    ps: parent_style
    """

    #if 'margin-bottom' in ts and ts['margin-bottom'] == '0px' \
    #        and 'margin-top' in ts and ts['margin-top'] == '0px':
    #    return 6

    if 'margin-top' not in ps or 'margin-bottom' not in ps:
        return 0

    if 'font-weight' in ts and ts['font-weight'] == '600' \
            and 'font-size' in ts:
        if ps['margin-bottom'] == '12px':
            if ts['font-size'] == 'xx-large' and ps['margin-top'] == '18px':
                return 1
            if ts['font-size'] == 'x-large' and ps['margin-top'] == '16px':
                return 2
            if ts['font-size'] == 'large' and ps['margin-top'] == '14px':
                return 3
            if ts['font-size'] == 'medium' and ps['margin-top'] == '12px':
                return 4
        elif ps['margin-bottom'] == '4px' and ps['margin-top'] == '12px' \
                and ts['font-size'] == 'small':
            return 5
    return 0


class MyHtml2Text(html2text.HTML2Text):
    def __init__(self, out=None, baseurl=''):
        self.parent_class = html2text.HTML2Text
        self.parent_class.__init__(self, out, baseurl)
        self.hide_strikethrough = False
        self.convert_within_html_block = False
        self.not_in_html_block = [True]
        #self.span_stack = []
        #self.call_count = 1
        self.md_equiv_tags = {'a', 'b', 'br', 'body', 'blockquote', 'hr',
                              'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'h7',
                              'div', 'p', 'head', 'style', 'em', 'strong', 'i',
                              'code', 'tt', 'abbr', 'img', 'ol', 'ul', 'li',
                              'pre', 'del', 'strike', 'html', 'span'}

    def handle_startendtag(self, tag, attrs):
        if tag == "br":
            print("br tag")
            self.o("  \n")
        else:
            self.handle_starttag(tag, attrs)
            self.handle_endtag(tag)

    def handle_tag(self, tag, attrs, start):
        if tag in self.md_equiv_tags and (self.not_in_html_block[-1]
                                          or self.convert_within_html_block):
            if start:
                self.not_in_html_block.append(True)
            else:
                self.not_in_html_block.pop()
            self.parent_class.handle_tag(self, tag, attrs, start)
        else:
            if start:
                self.not_in_html_block.append(False)
                a = ''.join([' ' + x + '="' + y + '"' for x, y in attrs])
                self.o('<' + tag + a + ' >')
            else:
                self.o('</' + tag + '>')
                self.not_in_html_block.pop()

    def handle_emphasis(self, start, tag_style, parent_style):
        """handles various text emphases"""
        tag_emphasis = google_text_emphasis(tag_style)
        parent_emphasis = google_text_emphasis(parent_style)

        # handle Google's text emphasis
        hl = hn(tag_style, parent_style)
        strikethrough = 'line-through' in tag_emphasis and self.hide_strikethrough
        bold = 'bold' in tag_emphasis and not 'bold' in parent_emphasis and hl in {0, 6}
        italic = 'italic' in tag_emphasis and not 'italic' in parent_emphasis
        fixed = google_fixed_width_font(tag_style) and not \
                google_fixed_width_font(parent_style) and not self.pre

        if start:
            # crossed-out text must be handled before other attributes
            # in order not to output qualifiers unnecessarily
            if hl:
                self.o("#" * hl)
            if bold or italic or fixed or strikethrough:
                self.emphasis += 1
            if strikethrough:
                #self.quiet += 1
                self.o("<s>")
            if italic:
                self.o("_")
                self.drop_white_space += 1
            if bold:
                self.o("**")
                self.drop_white_space += 1
            if fixed:
                self.o('`')
                self.drop_white_space += 1
                self.code = True
        else:
            if bold or italic or fixed:
                # there must not be whitespace before closing emphasis mark
                self.emphasis -= 1
                self.space = 0
                self.outtext = self.outtext.rstrip()
            if fixed:
                if self.drop_white_space:
                    # empty emphasis, drop it
                    self.drop_last(1)
                    self.drop_white_space -= 1
                else:
                    self.o('`')
                self.code = False
            if bold:
                if self.drop_white_space:
                    # empty emphasis, drop it
                    self.drop_last(2)
                    self.drop_white_space -= 1
                else:
                    self.o("**")
            if italic:
                if self.drop_white_space:
                    # empty emphasis, drop it
                    self.drop_last(1)
                    self.drop_white_space -= 1
                else:
                    self.o("_")
            # space is only allowed after *all* emphasis marks
            if (bold or italic) and not self.emphasis:
                    self.o(" ")
            if strikethrough:
                #self.quiet -= 1
                self.o("</s>")

    def google_nest_count(self, style):
        """calculate the nesting count of google doc lists"""
        if 'margin-left' in style:
            return int(style['margin-left'][:-2]) // self.google_list_indent
        return 0
