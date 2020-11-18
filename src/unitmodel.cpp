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
#include "unitmodel.h"
#include <KLocalizedContext>
#include <KLocalizedString>
#include <kunitconversion/converter.h>

UnitModel::UnitModel()
{
    m_units = KUnitConversion::Converter().category(KUnitConversion::AccelerationCategory).units();
}
QVariant UnitModel::data(const QModelIndex &index, int role) const
{
    if (index.row() >= 0 && index.row() < m_units.count())
        return m_units.at(index.row()).symbol() + " " + m_units.at(index.row()).description();
    else
        return QVariant();
}

int UnitModel::rowCount(const QModelIndex &parent) const
{
    return m_units.count();
}
QHash<int, QByteArray> UnitModel::roleNames() const
{
    return {{Qt::DisplayRole, "name"}};
}

void UnitModel::changeUnit(QString type)
{
    Q_EMIT layoutAboutToBeChanged();
    m_units = KUnitConversion::Converter().category(static_cast<KUnitConversion::CategoryId>(categoryToEnum.find(type)->second)).units();
    Q_EMIT layoutChanged();
}

QString UnitModel::getRet(double val, int fromTypeIndex, int toTypeIndex)
{
    if (fromTypeIndex < 0 || toTypeIndex < 0 || fromTypeIndex >= m_fromUnitID.size() || toTypeIndex >= m_toUnitID.size())
        return {};

    KUnitConversion::Value fromVal(val, m_fromUnitID.at(fromTypeIndex));
    return fromVal.convertTo(m_toUnitID.at(toTypeIndex)).toString();
};

QStringList UnitModel::search(QString keyword, int field)
{
    QStringList list;
    QVector<KUnitConversion::UnitId> *vec;
    if (field == 0)
        vec = &m_fromUnitID;
    else
        vec = &m_toUnitID;

    vec->clear();

    for (auto unit : m_units) {
        if (unit.description().indexOf(keyword) != -1 || unit.symbol().indexOf(keyword) != -1) {
            list.append(unit.symbol() + " " + unit.description());
            vec->append(unit.id());
        }
    }
    return list;
}
const std::unordered_map<QString, int> UnitModel::categoryToEnum = {{"Acceleration", KUnitConversion::AccelerationCategory},
                                                                    {"Angle", KUnitConversion::AngleCategory},
                                                                    {"Area", KUnitConversion::AreaCategory},
                                                                    {"Binary Data", KUnitConversion::BinaryDataCategory},
                                                                    {"Currency", KUnitConversion::CurrencyCategory},
                                                                    {"Density", KUnitConversion::DensityCategory},
                                                                    {"Electrical Current", KUnitConversion::ElectricalCurrentCategory},
                                                                    {"Electrical Resistance", KUnitConversion::ElectricalResistanceCategory},
                                                                    {"Energy", KUnitConversion::EnergyCategory},
                                                                    {"Force", KUnitConversion::ForceCategory},
                                                                    {"Frequency", KUnitConversion::FrequencyCategory},
                                                                    {"Fuel Efficiency", KUnitConversion::FuelEfficiencyCategory},
                                                                    {"Length", KUnitConversion::LengthCategory},
                                                                    {"Mass", KUnitConversion::MassCategory},
                                                                    {"Permeability", KUnitConversion::PermeabilityCategory},
                                                                    {"Power", KUnitConversion::PowerCategory},
                                                                    {"Pressure", KUnitConversion::PressureCategory},
                                                                    {"Temperature", KUnitConversion::TemperatureCategory},
                                                                    {"Thermal Conductivity", KUnitConversion::ThermalConductivityCategory},
                                                                    {"Thermal Flux", KUnitConversion::ThermalFluxCategory},
                                                                    {"Thermal Generation", KUnitConversion::ThermalGenerationCategory},
                                                                    {"Time", KUnitConversion::TimeCategory},
                                                                    {"Velocity", KUnitConversion::VelocityCategory},
                                                                    {"Volume", KUnitConversion::VolumeCategory},
                                                                    {"Voltage", KUnitConversion::VoltageCategory}};
