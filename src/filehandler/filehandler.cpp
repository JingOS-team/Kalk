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
    m_document(nullptr){}

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

QString FileHandler::fileName() const {
    const QString filePath = QQmlFile::urlToLocalFileOrQrc(m_fileUrl);
    const QString fileName = QFileInfo(filePath).fileName();
    if (fileName.isEmpty()) {
        return QStringLiteral("untitled.lcs");
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

QTextDocument *FileHandler::textDocument() const {
    if (!m_document) {
        return nullptr;
    }

    return m_document->textDocument();
}
