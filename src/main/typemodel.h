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
