/*
 * This file is part of Kalk
 *
 * Copyright (C) 2020 Han Young <hanyoung@protonmail.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 */
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
