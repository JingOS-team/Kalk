#include "unitmodel.h"
#include <KUnitConversion/kunitconversion/value.h>
UnitModel::UnitModel()
{
}

double UnitModel::getRet(double val, QString fromType, QString toType)
{
    KUnitConversion::Value converter(val, unitsToEnum.find(fromType));
    return converter.convertTo(unitsToEnum.find(toType));
}
