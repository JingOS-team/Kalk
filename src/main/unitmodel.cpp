#include "unitmodel.h"
#include <kunitconversion/value.h>
UnitModel::UnitModel()
{
}

double UnitModel::getRet(double val, QString fromType, QString toType)
{
    KUnitConversion::Value converter(val, static_cast<KUnitConversion::UnitId>(unitsToEnum.find(fromType)->second));
    return converter.convertTo(static_cast<KUnitConversion::UnitId>(unitsToEnum.find(toType)->second)).number();
}
