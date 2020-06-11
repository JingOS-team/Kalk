set(kalk_SRCS
    main/main.cpp
    calculator.qrc)

add_executable(kalk ${kalk_SRCS})
target_link_libraries(kalk Qt5::Core Qt5::Gui Qt5::Widgets Qt5::Qml Qt5::Quick Qt5::QuickControls2)

install(TARGETS kalk ${KF5_INSTALL_TARGETS_DEFAULT_ARGS})
