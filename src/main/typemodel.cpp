/*
 * This file is part of Kalk
 *
 * Copyright (C) 2020 Han Young <hanyoung@protonmail.com>
 *
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
#include "typemodel.h"
#include "unitmodel.h"
#include <KLocalizedContext>
#include <KLocalizedString>
#include <kunitconversion/value.h>
TypeModel::TypeModel()
{
}

QVariant TypeModel::data(const QModelIndex &index, int role) const
{
    return i18n((unitsType.at(index.row())).toLatin1());
}

int TypeModel::rowCount(const QModelIndex &parent) const
{
    return unitsType.size();
}
QHash<int, QByteArray> TypeModel::roleNames() const
{
    return {{Qt::DisplayRole, "name"}};
}

void TypeModel::currentIndex(int index)
{
    emit categoryChanged(unitsType.at(index));
};
const std::array<QString, 25> TypeModel::unitsType = {"Acceleration",
                                                      "Angle",
                                                      "Area",
                                                      "Binary Data",
                                                      "Currency",
                                                      "Density",
                                                      "Electrical Current",
                                                      "Electrical Resistance",
                                                      "Energy",
                                                      "Force",
                                                      "Frequency",
                                                      "Fuel Efficiency",
                                                      "Length",
                                                      "Mass",
                                                      "Permeability",
                                                      "Power",
                                                      "Pressure",
                                                      "Temperature",
                                                      "Thermal Conductivity",
                                                      "Thermal Flux",
                                                      "Thermal Generation",
                                                      "Time",
                                                      "Velocity",
                                                      "Volume",
                                                      "Voltage"};
