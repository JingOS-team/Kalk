#ifndef HISTORYMANAGER_H
#define HISTORYMANAGER_H

#include <QAbstractListModel>
#include <QObject>

class HistoryManager : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString expression WRITE addExpression)
public:
    HistoryManager();
    int rowCount(const QModelIndex &parent) const override
    {
        return historyList.count();
    };
    QVariant data(const QModelIndex &index, int role) const override
    {
        return historyList.at(index.row());
    };
    inline void addExpression(QString string)
    {
        historyList.append(string);
        this->save();
        emit layoutChanged();
    };
    Q_INVOKABLE void clearHistory();

private:
    QList<QString> historyList;
    void save();
};

#endif // HISTORYMANAGER_H
