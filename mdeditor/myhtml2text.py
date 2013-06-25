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

    def google_nest_count(self, style):
        """calculate the nesting count of google doc lists"""
        if 'margin-left' in style:
            return int(style['margin-left'][:-2]) // self.google_list_indent
        return 0
