# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'mdeditwindow.ui'
#
# Created: Wed Jun 26 15:57:45 2013
#      by: pyside-uic 0.2.14 running on PySide 1.1.2
#
# WARNING! All changes made in this file will be lost!

from PySide import QtCore, QtGui

class Ui_MarkdownEditWindow(object):
    def setupUi(self, MarkdownEditWindow):
        MarkdownEditWindow.setObjectName("MarkdownEditWindow")
        MarkdownEditWindow.resize(724, 559)
        self.centralwidget = QtGui.QWidget(MarkdownEditWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.verticalLayout = QtGui.QVBoxLayout(self.centralwidget)
        self.verticalLayout.setObjectName("verticalLayout")
        self.mdEdit = QtGui.QTextEdit(self.centralwidget)
        self.mdEdit.setObjectName("mdEdit")
        self.verticalLayout.addWidget(self.mdEdit)
        self.htmlEdit = QtWebKit.QWebView(self.centralwidget)
        self.htmlEdit.setEnabled(False)
        self.htmlEdit.setUrl(QtCore.QUrl("about:blank"))
        self.htmlEdit.setObjectName("htmlEdit")
        self.verticalLayout.addWidget(self.htmlEdit)
        MarkdownEditWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtGui.QMenuBar(MarkdownEditWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 724, 25))
        self.menubar.setObjectName("menubar")
        MarkdownEditWindow.setMenuBar(self.menubar)
        self.statusbar = QtGui.QStatusBar(MarkdownEditWindow)
        self.statusbar.setObjectName("statusbar")
        MarkdownEditWindow.setStatusBar(self.statusbar)
        self.toolBar = QtGui.QToolBar(MarkdownEditWindow)
        self.toolBar.setObjectName("toolBar")
        MarkdownEditWindow.addToolBar(QtCore.Qt.TopToolBarArea, self.toolBar)
        self.actionSwitchMode = QtGui.QAction(MarkdownEditWindow)
        self.actionSwitchMode.setCheckable(True)
        self.actionSwitchMode.setObjectName("actionSwitchMode")
        self.toolBar.addAction(self.actionSwitchMode)
        self.toolBar.addSeparator()

        self.retranslateUi(MarkdownEditWindow)
        QtCore.QObject.connect(self.actionSwitchMode, QtCore.SIGNAL("toggled(bool)"), self.mdEdit.setHidden)
        QtCore.QObject.connect(self.actionSwitchMode, QtCore.SIGNAL("toggled(bool)"), self.htmlEdit.setVisible)
        QtCore.QObject.connect(self.actionSwitchMode, QtCore.SIGNAL("toggled(bool)"), self.mdEdit.setDisabled)
        QtCore.QObject.connect(self.actionSwitchMode, QtCore.SIGNAL("toggled(bool)"), self.htmlEdit.setEnabled)
        QtCore.QMetaObject.connectSlotsByName(MarkdownEditWindow)

    def retranslateUi(self, MarkdownEditWindow):
        MarkdownEditWindow.setWindowTitle(QtGui.QApplication.translate("MarkdownEditWindow", "MainWindow", None, QtGui.QApplication.UnicodeUTF8))
        self.toolBar.setWindowTitle(QtGui.QApplication.translate("MarkdownEditWindow", "toolBar", None, QtGui.QApplication.UnicodeUTF8))
        self.actionSwitchMode.setText(QtGui.QApplication.translate("MarkdownEditWindow", "WYSIWYG", None, QtGui.QApplication.UnicodeUTF8))

from PySide import QtWebKit
