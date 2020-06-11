set(kalk_SRCS
    main/main.cpp
    main/historymanager.cpp
    calculator.qrc)

add_executable(kalk ${kalk_SRCS})
target_link_libraries(kalk
    Qt5::Core
    Qt5::Widgets
    Qt5::Qml
    Qt5::QuickControls2
    KF5::ConfigCore
    KF5::I18n
    KF5::CoreAddons)

install(TARGETS kalk ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})
