/*
 * This file is part of Kalk
 *
 * Copyright (C) 2020 Han Young <hanyoung@protonmail.com>
 *               2021 Bob <pengbo·wu@jingos.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 */
#ifndef MATHENGINE_H
#define MATHENGINE_H
#include "mathengine/driver.hh"
#include <QObject>
class MathEngine : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString result READ result WRITE setResult NOTIFY resultChanged)
    Q_PROPERTY(bool error READ error NOTIFY resultChanged)

public:
    Q_INVOKABLE bool parse(QString expr);

    inline QString result()
    {
        return result_;
    };

    inline void setResult(QString result)
    {
        result_ = result;
        mDriver.result = 0;
    };

    inline bool error()
    {
        return mDriver.syntaxError_;
    };

signals:
    void resultChanged();

private:
    bool containExpression(QString expr);
    driver mDriver;
    QString result_;
};

#endif
