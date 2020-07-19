#ifndef MATHENGINE_H
#define MATHENGINE_H
#include <QObject>
#include "../mathengine/driver.hh"
class MathEngine :public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString result READ result NOTIFY resultChanged)
public:
    MathEngine();
    Q_INVOKABLE void parse(QString expr);
    inline QString result(){return  result_;};
signals:
    void resultChanged();
private:
    driver mDriver;
    QString result_;
};

#endif
