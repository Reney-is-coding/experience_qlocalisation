cmake_minimum_required(VERSION 3.10)
  set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_executable(app
    src/main.cpp
    qml.qrc
)

set_target_properties(app PROPERTIES
    AUTORCC TRUE
    AUTOMOC TRUE
)


target_compile_features(
    app
    PRIVATE
        cxx_auto_type
        cxx_generic_lambdas
)


#add_subdirectory(plugin)
#add_dependencies(app plugin)
# Needs to copy plugin files...

find_package(Qt5 COMPONENTS Core Qml Quick Widgets Positioning REQUIRED)

#qt5_use_package(app Widgets)
#qt5_use_package(app Core)
#qt5_use_package(app Qml)
#qt5_use_package(app Quick)


target_link_libraries(app Qt5::Core Qt5::Qml Qt5::Quick Qt5::Widgets Qt5::Positioning)
