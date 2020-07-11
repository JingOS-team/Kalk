#include "mathengine.h"
#include <QDebug>
MathEngine::MathEngine()
{
}

void MathEngine::parse(QString expr)
{
    engine_.parse(expr.toStdString());
    qDebug() << engine_.result;
    result_ = QString::number(engine_.result);
    emit resultChanged();
}
