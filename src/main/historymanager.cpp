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

#include "historymanager.h"
#include <QDebug>
#include <QDir>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QStandardPaths>

HistoryManager::HistoryManager()
{
    // create cache location if it does not exist, and load cache
    QDir dir(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/kalk");
    if (!dir.exists())
        dir.mkpath(".");
    QFile file(dir.path() + "/history.json");
    if (file.exists()) {
        file.open(QIODevice::ReadOnly);
        QJsonDocument doc(QJsonDocument::fromJson(file.readAll()));
        for (auto record : doc.array()) {
            historyList.append(record.toString());
        }
        file.close();
    }
}

void HistoryManager::clearHistory()
{
    historyList.clear();
    QDir dir(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation) + "/kalk");
    QFile file(dir.path() + "history.json");
    file.remove();
    emit layoutChanged();
    this->save();
}

void HistoryManager::save()
{
    QJsonDocument doc;
    QJsonArray array;
    for (auto record : historyList) {
        array.append(record);
    }
    doc.setArray(array);
    QString url = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation);
    QFile file(url + "/kalk/history.json");
    file.open(QIODevice::WriteOnly);
    file.write(doc.toJson(QJsonDocument::Compact));
    file.close();
    qDebug() << "save" << file.fileName();
}
