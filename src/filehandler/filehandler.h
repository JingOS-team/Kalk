#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QFont>
#include <QObject>
#include <QTextCursor>
#include <QUrl>

QT_BEGIN_NAMESPACE
class QTextDocument;
class QQuickTextDocument;
QT_END_NAMESPACE

class FileHandler : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QQuickTextDocument *document READ document WRITE setDocument NOTIFY documentChanged)
    Q_PROPERTY(int cursorPosition READ cursorPosition WRITE setCursorPosition NOTIFY cursorPositionChanged)
    Q_PROPERTY(int selectionStart READ selectionStart WRITE setSelectionStart NOTIFY selectionStartChanged)
    Q_PROPERTY(int selectionEnd READ selectionEnd WRITE setSelectionEnd NOTIFY selectionEndChanged)

    Q_PROPERTY(QString fileName READ fileName NOTIFY fileUrlChanged)
    Q_PROPERTY(QString fileType READ fileType NOTIFY fileUrlChanged)
    Q_PROPERTY(QUrl fileUrl READ fileUrl NOTIFY fileUrlChanged)

public:
    explicit FileHandler(QObject *parent = nullptr);

    QQuickTextDocument *document() const;
    void setDocument(QQuickTextDocument *document);

    int cursorPosition() const;
    void setCursorPosition(int position);

    int selectionStart() const;
    void setSelectionStart(int position);

    int selectionEnd() const;
    void setSelectionEnd(int position);

    QString fileName() const;
    QString fileType() const;
    QUrl fileUrl() const;

public Q_SLOTS:
    void load(const QUrl &fileUrl);
    void saveAs(const QUrl &fileUrl);

Q_SIGNALS:
    void documentChanged();
    void cursorPositionChanged();
    void selectionStartChanged();
    void selectionEndChanged();

    void textChanged();
    void fileUrlChanged();

    void loaded(const QString &text);
    void error(const QString &message);

private:
    QTextCursor textCursor() const;
    QTextDocument *textDocument() const;
    void mergeFormatOnWordOrSelection(const QTextCharFormat &format);

    QQuickTextDocument *m_document;

    int m_cursorPosition;
    int m_selectionStart;
    int m_selectionEnd;

    QUrl m_fileUrl;
};

#endif // FILEHANDLER_H
