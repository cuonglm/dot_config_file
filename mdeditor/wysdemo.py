#!/usr/bin/env python3

import sys

from PySide.QtCore import SIGNAL
from PySide.QtGui import QDialog
from PySide.QtGui import QTextCursor, QTextCharFormat, QFont
from PySide.QtGui import QApplication

import markdown
import myhtml2text
#import html2text
#import markdownify

from Ui_MarkdownEditDialog import Ui_MarkdownEditDialog


class MarkdownDialog(Ui_MarkdownEditDialog, QDialog):

    def __init__(self, parent=None):
        super(MarkdownDialog, self).__init__(parent)
        self.setupUi(self)
        self.htmlEdit.setVisible(False)

        self.connect(self.buttonB, SIGNAL("clicked(bool)"), self.boldText)
        self.connect(self.buttonI, SIGNAL("clicked(bool)"), self.italicText)
        self.connect(self.buttonMode, SIGNAL("toggled(bool)"), self.changeMode)

    def boldText(self, checked):
        if self.htmlEdit.isVisible():
            cursor = self.htmlEdit.textCursor()
            if cursor.hasSelection():
                fmt = QTextCharFormat()
                fmt.setFontWeight(QFont.Bold)
                self.htmlEdit.mergeCurrentCharFormat(fmt)
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
            cursor = self.htmlEdit.textCursor()
            if cursor.hasSelection():
                fmt = QTextCharFormat()
                fmt.setFontItalic(True)
                self.htmlEdit.mergeCurrentCharFormat(fmt)
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
            print(html)
            self.htmlEdit.setHtml(html)
        else:
            #h2t = html2text.HTML2Text()
            h2t = myhtml2text.MyHtml2Text()
            h2t.google_doc = True
            html = self.htmlEdit.toHtml()
            print(html)
            md = h2t.handle(html)
            #md = markdownify.markdownify(html, ['style'])
            self.mdEdit.setPlainText(md)


if __name__ == "__main__":
    app = QApplication(sys.argv)
    d = MarkdownDialog()
    d.show()
    app.exec_()
