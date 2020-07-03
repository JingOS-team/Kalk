#include "unitmodel.h"
#include <KLocalizedContext>
#include <KLocalizedString>
#include <kunitconversion/value.h>

UnitModel::UnitModel()
{
}
QVariant UnitModel::data(const QModelIndex &index, int role) const
{
    return i18n(units_.at(index.row()).description().toLatin1());
}

int UnitModel::rowCount(const QModelIndex &parent) const
{
    return units_.count();
}
QHash<int, QByteArray> UnitModel::roleNames() const
{
    return {{Qt::DisplayRole, "name"}};
}
