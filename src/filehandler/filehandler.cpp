#include "filehandler.h"

#include <QFile>
#include <QFileInfo>
#include <QFileSelector>
#include <QQmlFile>
#include <QQmlFileSelector>
#include <QQuickTextDocument>
#include <QTextCharFormat>
#include <QTextCodec>
#include <QTextDocument>

FileHandler::FileHandler(QObject *parent):QObject(parent),
    m_document(nullptr),
    m_cursorPosition(-1),
    m_selectionStart(0),
    m_selectionEnd(0) {}

QQuickTextDocument *FileHandler::document() const {
    return m_document;
}

void FileHandler::setDocument(QQuickTextDocument *document) {
    if (document == m_document) {
        return;
    }

    m_document = document;
    emit documentChanged();
}

int FileHandler::cursorPosition() const {
    return m_cursorPosition;
}

void FileHandler::setCursorPosition(int position) {
    if (position == m_cursorPosition) {
        return;
    }

    m_cursorPosition = position;
    emit cursorPositionChanged();
}

int FileHandler::selectionStart() const{
    return m_selectionStart;
}

void FileHandler::setSelectionStart(int position){
    if (position == m_selectionStart) {
        return;
    }

    m_selectionStart = position;
    emit selectionStartChanged();
}

int FileHandler::selectionEnd() const {
    return m_selectionEnd;
}

void FileHandler::setSelectionEnd(int position) {
    if (position == m_selectionEnd) {
        return;
    }

    m_selectionEnd = position;
    emit selectionEndChanged();
}

QString FileHandler::fileName() const {
    const QString filePath = QQmlFile::urlToLocalFileOrQrc(m_fileUrl);
    const QString fileName = QFileInfo(filePath).fileName();
    if (fileName.isEmpty()) {
        return QStringLiteral("untitled.txt");
    }
    return fileName;
}

QString FileHandler::fileType() const {
    return QFileInfo(fileName()).suffix();
}

QUrl FileHandler::fileUrl() const {
    return m_fileUrl;
}

void FileHandler::load(const QUrl &fileUrl) {
    if (fileUrl == m_fileUrl) {
        return;
    }

    QQmlEngine *engine = qmlEngine(this);
    if (!engine) {
        qWarning() << "load() called before DocumentHandler has QQmlEngine";
        return;
    }

    const QUrl path = QQmlFileSelector::get(engine)->selector()->select(fileUrl);
    const QString fileName = QQmlFile::urlToLocalFileOrQrc(path);
    if (QFile::exists(fileName)) {
        QFile file(fileName);
        if (file.open(QFile::ReadOnly)) {
            QByteArray data = file.readAll();
            QTextCodec *codec = QTextCodec::codecForHtml(data);
            if (QTextDocument *doc = textDocument()) {
                doc->setModified(false);
            }

            emit loaded(codec->toUnicode(data));
        }
    }

    m_fileUrl = fileUrl;
    emit fileUrlChanged();
}

void FileHandler::saveAs(const QUrl &fileUrl) {
    QTextDocument *doc = textDocument();
    if (!doc) {
        return;
    }

    const QString filePath = fileUrl.toLocalFile();
    QFile file(filePath);
    if (!file.open(QFile::WriteOnly | QFile::Truncate | QFile::Text)) {
        emit error(tr("Cannot save: ") + file.errorString());
        return;
    }
    file.write(doc->toPlainText().toUtf8());
    file.close();

    if (fileUrl == m_fileUrl)
        return;

    m_fileUrl = fileUrl;
    emit fileUrlChanged();
}

QTextCursor FileHandler::textCursor() const {
    QTextDocument *doc = textDocument();
    if (!doc)
        return QTextCursor();

    QTextCursor cursor = QTextCursor(doc);
    if (m_selectionStart != m_selectionEnd) {
        cursor.setPosition(m_selectionStart);
        cursor.setPosition(m_selectionEnd, QTextCursor::KeepAnchor);
    } else {
        cursor.setPosition(m_cursorPosition);
    }
    return cursor;
}

QTextDocument *FileHandler::textDocument() const {
    if (!m_document) {
        return nullptr;
    }

    return m_document->textDocument();
}

void FileHandler::mergeFormatOnWordOrSelection(const QTextCharFormat &format) {
    QTextCursor cursor = textCursor();
    if (!cursor.hasSelection()) {
        cursor.select(QTextCursor::WordUnderCursor);
    }
    cursor.mergeCharFormat(format);
}
