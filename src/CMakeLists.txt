# Translations
file(GLOB LiriCalculator_TRANSLATIONS "${CMAKE_CURRENT_SOURCE_DIR}/translations/*_*.ts")
qt5_add_translation(LiriCalculator_QM_FILES ${LiriCalculator_TRANSLATIONS})
if(WIN32)
    set(_translations_destdir "${CMAKE_CURRENT_BINARY_DIR}/translations")
elseif(APPLE)
    set(_translations_destdir "${CMAKE_CURRENT_BINARY_DIR}/Contents/Resources/data/translations")
elseif(LINUX OR BSD)
    set(_translations_destdir "${INSTALL_DATADIR}/liri-calculator/translations")
endif()
if(DEFINED _translations_destdir)
    install(FILES ${LiriCalculator_QM_FILES} DESTINATION "${_translations_destdir}")
endif()

if(APPLE OR WIN32)
    set(LiriCalculator_OUTPUT_NAME "LiriCalculator")
else()
    set(LiriCalculator_OUTPUT_NAME "liri-calculator")
endif()

liri_add_executable(LiriCalculator
    OUTPUT_NAME
        "${LiriCalculator_OUTPUT_NAME}"
    SOURCES
        main/main.cpp
        filehandler/filehandler.cpp
        filehandler/filehandler.h
        ${LiriCalculator_QM_FILES}
    RESOURCES
        calculator.qrc
    DEFINES
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
    APPDATA
        "${CMAKE_CURRENT_SOURCE_DIR}/../data/io.liri.Calculator.appdata.xml"
    DESKTOP
        "${CMAKE_CURRENT_SOURCE_DIR}/../data/io.liri.Calculator.desktop"
    LIBRARIES
        Qt5::Core
        Qt5::Gui
        Qt5::Widgets
        Qt5::Qml
        Qt5::Quick
        Qt5::QuickControls2
    GUI
)
set_target_properties(LiriCalculator PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER "io.liri.Calculator"
    MACOSX_BUNDLE_ICON_FILE "io.liri.Calculator"
    MACOSX_BUNDLE_SHORT_VERSION_STRING "${PROJECT_VERSION}"
)
