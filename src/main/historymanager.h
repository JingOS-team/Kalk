#ifndef HISTORYMANAGER_H
#define HISTORYMANAGER_H

#include <QObject>

class HistoryManager
{
    Q_OBJECT
    Q_PROPERTY(QString expression WRITE addExpression)
    Q_PROPERTY(QList<QString> history READ history)
public:
    HistoryManager();
    inline void addExpression(QString string) {
        historyList.append(string);
        this->save();
    };
    inline QList<QString> history() {return historyList;}
    Q_INVOKABLE void clearHistory();

private:
    QList<QString> historyList;
    void save();
};

#endif // HISTORYMANAGER_H
