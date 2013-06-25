#!/usr/bin/env python3

import sys

from PySide.QtCore import SIGNAL
from PySide.QtGui import QDialog
from PySide.QtGui import QTextCursor, QTextCharFormat, QFont
from PySide.QtGui import QApplication
from PySide.QtWebKit import QWebView, QWebPage, QWebFrame

import markdown
import myhtml2text
#import html2text
#import markdownify

from Ui_MarkdownEditDialogWebKit import Ui_MarkdownEditDialogWebKit


class MarkdownDialog(Ui_MarkdownEditDialogWebKit, QDialog):

    def __init__(self, parent=None):
        super(MarkdownDialog, self).__init__(parent)
        self.setupUi(self)
        self.htmlEdit.setVisible(False)
        self.page = self.htmlEdit.page()
        self.page.setContentEditable(True)
        self.frame = self.page.currentFrame()

        self.connect(self.buttonB, SIGNAL("clicked(bool)"), self.boldText)
        self.connect(self.buttonI, SIGNAL("clicked(bool)"), self.italicText)
        self.connect(self.buttonMode, SIGNAL("toggled(bool)"), self.changeMode)

    def boldText(self, checked):
        if self.htmlEdit.isVisible():
            if self.page.hasSelection():
                pass
            else:
                self.page.triggerAction(QWebPage.ToggleBold)
        else:
            cursor = self.mdEdit.textCursor()
            if cursor.hasSelection():
                start = cursor.selectionStart()
                end = cursor.selectionEnd() + 2
                cursor.setPosition(start, QTextCursor.MoveAnchor)
                cursor.insertText("**")
                cursor.setPosition(end, QTextCursor.MoveAnchor)
                cursor.insertText("**")

    def italicText(self, checked):
        if self.htmlEdit.isVisible():
            if self.page.hasSelection():
                pass
            else:
                self.page.triggerAction(QWebPage.ToggleItalic)
        else:
            cursor = self.mdEdit.textCursor()
            if cursor.hasSelection():
                start = cursor.selectionStart()
                end = cursor.selectionEnd() + 1
                cursor.setPosition(start, QTextCursor.MoveAnchor)
                cursor.insertText("_")
                cursor.setPosition(end, QTextCursor.MoveAnchor)
                cursor.insertText("_")

    def changeMode(self, isWYSMode):
        if isWYSMode:
            html = markdown.markdown(self.mdEdit.toPlainText())
            print("\n\nMarkdown to HTML:\n\nHTML:\n")
            print(html)
            self.htmlEdit.setHtml(html)
        else:
            #h2t = html2text.HTML2Text()
            h2t = myhtml2text.MyHtml2Text()
            h2t.google_doc = True
            html = self.frame.toHtml()
            print("\n\nHTML to md:\n\nHTML:\n")
            print(html)
            md = h2t.handle(html)
            print("\nMarkdown:\n" + md)
            #md = markdownify.markdownify(html, ['style'])
            self.mdEdit.setPlainText(md)


if __name__ == "__main__":
    app = QApplication(sys.argv)
    d = MarkdownDialog()
    d.show()
    app.exec_()
