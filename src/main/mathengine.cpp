#include "mathengine.h"
MathEngine::MathEngine() {};

void MathEngine::parse(QString expr)
{
    try {
        mDriver.parse(expr.toStdString());
    } catch (yy::parser::syntax_error) {
        return;
    };
    result_ = QString::number(mDriver.result);
    emit resultChanged();
}
