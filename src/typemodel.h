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
#ifndef UNITMODEL_H
#define UNITMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <array>
#include <kunitconversion/converter.h>
#include <unordered_map>
using namespace KUnitConversion;
class TypeModel : public QAbstractListModel
{
    Q_OBJECT
public:
    TypeModel();
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE void currentIndex(int index);
signals:
    void categoryChanged(QString type);

private:
    KUnitConversion::Converter mConverter;
    static const std::array<QString, 25> unitsType;
};

#endif // UNITMODEL_H
