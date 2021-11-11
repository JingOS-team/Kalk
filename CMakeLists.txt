#  This file is part of Kalk
#
#  Copyright (C) 2020 Cahfofpai
#                     Han Young <hanyoung@protonmail.com>
#                2021 Bob <pengbo·wu@jingos.com>
#
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

project(Kalk)

##########################Pre-Build######################################
find_program(flex QUIET)
find_program(bison QUIET)
execute_process(
    COMMAND bison -o ${CMAKE_CURRENT_SOURCE_DIR}/src/mathengine/parser.cc ${CMAKE_CURRENT_SOURCE_DIR}/src/mathengine/parser.yy
    COMMAND flex -o ${CMAKE_CURRENT_SOURCE_DIR}/src/mathengine/scanner.cc ${CMAKE_CURRENT_SOURCE_DIR}/src/mathengine/scanner.ll
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
##########################END############################################

cmake_minimum_required(VERSION 2.8.12)
set(KF5_MIN_VERSION "5.18.0")
set(QT_MIN_VERSION "5.5.0")
if("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
    message(FATAL_ERROR "This application requires an out of source build. Please
        create a separate build directory.")
endif()

include(FeatureSummary)

find_package(ECM ${KF5_MIN_VERSION} REQUIRED NO_MODULE)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})

include(ECMSetupVersion)
include(ECMGenerateHeaders)
include(KDEInstallDirs)
include(KDECMakeSettings)
include(ECMPoQmTools)
include(KDECompilerSettings NO_POLICY_SCOPE)
find_package(Qt5 ${QT_MIN_VERSION} REQUIRED NO_MODULE COMPONENTS Core Quick Test Gui QuickControls2 Widgets)
find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS
        Config
        Kirigami2
        I18n
        CoreAddons
        UnitConversion)
add_subdirectory(src)
install(PROGRAMS org.kde.kalk.desktop DESTINATION ${KDE_INSTALL_APPDIR})
install(FILES org.kde.kalk.appdata.xml DESTINATION ${KDE_INSTALL_METAINFODIR})
install(FILES jcalicon.svg DESTINATION ${KDE_INSTALL_FULL_ICONDIR}/hicolor/scalable/apps/)
feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)