#ifndef MATHENGINE_H
#define MATHENGINE_H

#include "Parser/driver.hh"
#include <QObject>
class MathEngine : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString result READ result NOTIFY resultChanged)
public:
    MathEngine();
    Q_INVOKABLE void parse(QString expr);
    inline QString result()
    {
        return result_;
    };
signals:
    void resultChanged();

private:
    driver engine_;
    QString result_;
};

#endif // MATHENGINE_H
