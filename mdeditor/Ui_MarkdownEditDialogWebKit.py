# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'mdeditdialog-wk.ui'
#
# Created: Tue Jun 25 18:08:48 2013
#      by: pyside-uic 0.2.14 running on PySide 1.1.2
#
# WARNING! All changes made in this file will be lost!

from PySide import QtCore, QtGui

class Ui_MarkdownEditDialogWebKit(object):
    def setupUi(self, MarkdownEditDialogWebKit):
        MarkdownEditDialogWebKit.setObjectName("MarkdownEditDialogWebKit")
        MarkdownEditDialogWebKit.resize(456, 357)
        self.verticalLayout_2 = QtGui.QVBoxLayout(MarkdownEditDialogWebKit)
        self.verticalLayout_2.setObjectName("verticalLayout_2")
        self.horizontalLayout = QtGui.QHBoxLayout()
        self.horizontalLayout.setObjectName("horizontalLayout")
        self.buttonMode = QtGui.QPushButton(MarkdownEditDialogWebKit)
        self.buttonMode.setCheckable(True)
        self.buttonMode.setObjectName("buttonMode")
        self.horizontalLayout.addWidget(self.buttonMode)
        self.buttonB = QtGui.QPushButton(MarkdownEditDialogWebKit)
        self.buttonB.setObjectName("buttonB")
        self.horizontalLayout.addWidget(self.buttonB)
        self.buttonI = QtGui.QPushButton(MarkdownEditDialogWebKit)
        self.buttonI.setObjectName("buttonI")
        self.horizontalLayout.addWidget(self.buttonI)
        self.verticalLayout_2.addLayout(self.horizontalLayout)
        self.htmlEdit = QtWebKit.QWebView(MarkdownEditDialogWebKit)
        self.htmlEdit.setUrl(QtCore.QUrl("about:blank"))
        self.htmlEdit.setObjectName("htmlEdit")
        self.verticalLayout_2.addWidget(self.htmlEdit)
        self.mdEdit = QtGui.QPlainTextEdit(MarkdownEditDialogWebKit)
        self.mdEdit.setObjectName("mdEdit")
        self.verticalLayout_2.addWidget(self.mdEdit)

        self.retranslateUi(MarkdownEditDialogWebKit)
        QtCore.QObject.connect(self.buttonMode, QtCore.SIGNAL("toggled(bool)"), self.mdEdit.setHidden)
        QtCore.QObject.connect(self.buttonMode, QtCore.SIGNAL("toggled(bool)"), self.htmlEdit.setVisible)
        QtCore.QMetaObject.connectSlotsByName(MarkdownEditDialogWebKit)
        MarkdownEditDialogWebKit.setTabOrder(self.mdEdit, self.htmlEdit)
        MarkdownEditDialogWebKit.setTabOrder(self.htmlEdit, self.buttonMode)
        MarkdownEditDialogWebKit.setTabOrder(self.buttonMode, self.buttonB)
        MarkdownEditDialogWebKit.setTabOrder(self.buttonB, self.buttonI)

    def retranslateUi(self, MarkdownEditDialogWebKit):
        MarkdownEditDialogWebKit.setWindowTitle(QtGui.QApplication.translate("MarkdownEditDialogWebKit", "Markdown Editor", None, QtGui.QApplication.UnicodeUTF8))
        self.buttonMode.setText(QtGui.QApplication.translate("MarkdownEditDialogWebKit", "WYSIWYG", None, QtGui.QApplication.UnicodeUTF8))
        self.buttonB.setText(QtGui.QApplication.translate("MarkdownEditDialogWebKit", "B", None, QtGui.QApplication.UnicodeUTF8))
        self.buttonI.setText(QtGui.QApplication.translate("MarkdownEditDialogWebKit", "I", None, QtGui.QApplication.UnicodeUTF8))

from PySide import QtWebKit
