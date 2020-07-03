#ifndef MYUNITMODEL_H
#define MYUNITMODEL_H // this took me hours to debug, UNITMODEL is defined by kunitconversio

#include <QAbstractListModel>
#include <QObject>
#include <kunitconversion/unit.h>
#include <unordered_map>

class UnitModel : public QAbstractListModel
{
public:
    UnitModel();
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE void changeType(QString type);
    Q_INVOKABLE double getRet(double val, QString fromType, QString toType);

private:
    QList<KUnitConversion::Unit> units_;
};
#endif // UNITMODEL_H
