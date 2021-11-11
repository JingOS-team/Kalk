#  This file is part of Kalk
#
#  Copyright (C) 2020 Cahfofpai
#                     Han Young <hanyoung@protonmail.com>
#                2021 Bob <pengbo·wu@jingos.com>
#
#  $BEGIN_LICENSE:GPL3+$
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#  $END_LICENSE$
set(kalk_SRCS
    main.cpp
    historymanager.cpp
    unitmodel.cpp
    typemodel.cpp
    mathengine.cpp
    mathengine/parser.cc
    mathengine/scanner.cc
    mathengine/driver.cc
    calculator.qrc)
add_executable(kalk ${kalk_SRCS})

target_link_libraries(kalk
    Qt5::Core
    Qt5::Widgets
    Qt5::Qml
    Qt5::QuickControls2
    KF5::UnitConversion
    KF5::ConfigCore
    KF5::I18n
    KF5::CoreAddons
    jappcoreqt)
install(TARGETS kalk ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})