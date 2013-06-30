# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'mdeditdialog.ui'
#
# Created: Mon Jun 24 20:08:40 2013
#      by: pyside-uic 0.2.14 running on PySide 1.1.2
#
# WARNING! All changes made in this file will be lost!

from PySide import QtCore, QtGui

class Ui_MarkdownEditDialog(object):
    def setupUi(self, MarkdownEditDialog):
        MarkdownEditDialog.setObjectName("MarkdownEditDialog")
        MarkdownEditDialog.resize(456, 357)
        self.verticalLayout_2 = QtGui.QVBoxLayout(MarkdownEditDialog)
        self.verticalLayout_2.setObjectName("verticalLayout_2")
        self.horizontalLayout = QtGui.QHBoxLayout()
        self.horizontalLayout.setObjectName("horizontalLayout")
        self.buttonMode = QtGui.QPushButton(MarkdownEditDialog)
        self.buttonMode.setCheckable(True)
        self.buttonMode.setObjectName("buttonMode")
        self.horizontalLayout.addWidget(self.buttonMode)
        self.buttonB = QtGui.QPushButton(MarkdownEditDialog)
        self.buttonB.setObjectName("buttonB")
        self.horizontalLayout.addWidget(self.buttonB)
        self.buttonI = QtGui.QPushButton(MarkdownEditDialog)
        self.buttonI.setObjectName("buttonI")
        self.horizontalLayout.addWidget(self.buttonI)
        self.verticalLayout_2.addLayout(self.horizontalLayout)
        self.htmlEdit = QtGui.QTextEdit(MarkdownEditDialog)
        self.htmlEdit.setObjectName("htmlEdit")
        self.verticalLayout_2.addWidget(self.htmlEdit)
        self.mdEdit = QtGui.QPlainTextEdit(MarkdownEditDialog)
        self.mdEdit.setObjectName("mdEdit")
        self.verticalLayout_2.addWidget(self.mdEdit)

        self.retranslateUi(MarkdownEditDialog)
        QtCore.QObject.connect(self.buttonMode, QtCore.SIGNAL("toggled(bool)"), self.htmlEdit.setVisible)
        QtCore.QObject.connect(self.buttonMode, QtCore.SIGNAL("toggled(bool)"), self.mdEdit.setHidden)
        QtCore.QMetaObject.connectSlotsByName(MarkdownEditDialog)
        MarkdownEditDialog.setTabOrder(self.htmlEdit, self.mdEdit)
        MarkdownEditDialog.setTabOrder(self.mdEdit, self.buttonMode)
        MarkdownEditDialog.setTabOrder(self.buttonMode, self.buttonB)
        MarkdownEditDialog.setTabOrder(self.buttonB, self.buttonI)

    def retranslateUi(self, MarkdownEditDialog):
        MarkdownEditDialog.setWindowTitle(QtGui.QApplication.translate("MarkdownEditDialog", "Markdown Editor", None, QtGui.QApplication.UnicodeUTF8))
        self.buttonMode.setText(QtGui.QApplication.translate("MarkdownEditDialog", "WYSIWYG", None, QtGui.QApplication.UnicodeUTF8))
        self.buttonB.setText(QtGui.QApplication.translate("MarkdownEditDialog", "B", None, QtGui.QApplication.UnicodeUTF8))
        self.buttonI.setText(QtGui.QApplication.translate("MarkdownEditDialog", "I", None, QtGui.QApplication.UnicodeUTF8))

