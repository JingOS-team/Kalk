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
#ifndef MYUNITMODEL_H
#define MYUNITMODEL_H // this took me hours to debug, UNITMODEL is defined by kunitconversio

#include <QAbstractListModel>
#include <QObject>
#include <kunitconversion/unit.h>
#include <unordered_map>

class UnitModel : public QAbstractListModel
{
    Q_OBJECT
public:
    UnitModel();
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE double getRet(double val, int fromType, int toType); // use int index because text may be localized

public slots:
    void changeUnit(QString type);

private:
    QList<KUnitConversion::Unit> units_;
    static const std::unordered_map<QString, int> categoryToEnum;
};
#endif // UNITMODEL_H
