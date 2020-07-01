#ifndef UNITMODEL_H
#define UNITMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <unordered_map>
#include <array>
#include <KUnitConversion/kunitconversion/unit.h>
using namespace KUnitConversion;
class UnitModel : public QAbstractListModel
{
public:
    UnitModel();
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE void changeType(QString type);
};

static const std::array<QString,25> unitsType = {
    "Acceleration",
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
    "Fuel efficiency",
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
    "Voltage"
};
static const std::unordered_map<QString, int> unitsToEnum({
                                                              {"SquareYottameter", UnitId::SquareYottameter},
                                                              {"SquareZettameter", UnitId::SquareZettameter},
                                                              {"SquareExameter", UnitId::SquareExameter},
                                                              {"SquarePetameter", UnitId::SquarePetameter},
                                                              {"SquareTerameter", UnitId::SquareTerameter},
                                                              {"SquareGigameter", UnitId::SquareGigameter},
                                                              {"SquareMegameter", UnitId::SquareMegameter},
                                                              {"SquareKilometer", UnitId::SquareKilometer},
                                                              {"SquareHectometer", UnitId::SquareHectometer},
                                                              {"SquareDecameter", UnitId::SquareDecameter},
                                                              {"SquareMeter", UnitId::SquareMeter},
                                                              {"SquareDecimeter", UnitId::SquareDecimeter},
                                                              {"SquareCentimeter", UnitId::SquareCentimeter},
                                                              {"SquareMillimeter", UnitId::SquareMillimeter},
                                                              {"SquareMicrometer", UnitId::SquareMicrometer},
                                                              {"SquareNanometer", UnitId::SquareNanometer},
                                                              {"SquarePicometer", UnitId::SquarePicometer},
                                                              {"SquareFemtometer", UnitId::SquareFemtometer},
                                                              {"SquareAttometer", UnitId::SquareAttometer},
                                                              {"SquareZeptometer", UnitId::SquareZeptometer},
                                                              {"SquareYoctometer", UnitId::SquareYoctometer},
                                                              {"Acre", UnitId::Acre},
                                                              {"SquareFoot", UnitId::SquareFoot},
                                                              {"SquareInch", UnitId::SquareInch},
                                                              {"SquareMile", UnitId::SquareMile}
                                                          });
#endif // UNITMODEL_H
