#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QObject>
#include <QUrl>

QT_BEGIN_NAMESPACE
class QTextDocument;
class QQuickTextDocument;
QT_END_NAMESPACE

class FileHandler : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QQuickTextDocument *document READ document WRITE setDocument NOTIFY documentChanged)
    Q_PROPERTY(QString fileName READ fileName NOTIFY fileUrlChanged)
    Q_PROPERTY(QString fileType READ fileType NOTIFY fileUrlChanged)
    Q_PROPERTY(QUrl fileUrl READ fileUrl NOTIFY fileUrlChanged)

public:
    explicit FileHandler(QObject *parent = nullptr);

    QQuickTextDocument *document() const;
    void setDocument(QQuickTextDocument *document);
    QString fileName() const;
    QString fileType() const;
    QUrl fileUrl() const;

public Q_SLOTS:
    void load(const QUrl &fileUrl);
    void saveAs(const QUrl &fileUrl);

Q_SIGNALS:
    void documentChanged();
    void textChanged();
    void fileUrlChanged();
    void loaded(const QString &text);
    void error(const QString &message);

private:
    QTextDocument *textDocument() const;
    QQuickTextDocument *m_document;
    QUrl m_fileUrl;
};

#endif // FILEHANDLER_H
