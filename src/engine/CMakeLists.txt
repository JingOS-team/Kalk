file(GLOB ENGINE_QML_JS_FILES *.qml *.js)

# Make the files visible in the qtcreator tree
add_custom_target(ubuntu-calculator-app_engine_QMlFiles ALL SOURCES ${ENGINE_QML_JS_FILES})

install(FILES ${ENGINE_QML_JS_FILES} DESTINATION ${UBUNTU-CALCULATOR-APP_DIR}/engine)

