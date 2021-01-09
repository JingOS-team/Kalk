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
    units_ = KUnitConversion::Converter().category(KUnitConversion::AccelerationCategory).units();
}
QVariant UnitModel::data(const QModelIndex &index, int role) const
{
    return units_.at(index.row()).description();
}

int UnitModel::rowCount(const QModelIndex &parent) const
{
    return units_.count();
}
QHash<int, QByteArray> UnitModel::roleNames() const
{
    return {{Qt::DisplayRole, "name"}};
}

void UnitModel::changeUnit(QString type)
{
    emit layoutAboutToBeChanged();
    units_ = KUnitConversion::Converter().category(static_cast<KUnitConversion::CategoryId>(categoryToEnum.find(type)->second)).units();
    emit layoutChanged();
}

double UnitModel::getRet(double val, int fromType, int toType)
{
    KUnitConversion::Value fromVal(val, units_.at(fromType));
    return fromVal.convertTo(units_.at(toType)).number();
};
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
