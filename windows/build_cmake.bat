:: 26-05-2024
@echo off
:: Clean the build and application directories if they exist
IF EXIST build (
    rmdir /s /q build
)
IF EXIST application (
    rmdir /s /q application
)

:: Create the build and application directories
mkdir build
mkdir application

:: Navigate to the build directory
cd build

:: Run CMake to configure the project and generate build files
cmake ..

:: Build the project
cmake --build .

:: Check if the executable exists and run it
cd ..
IF EXIST application\cmake_imgui_app.exe (
    cd application
    cmake_imgui_app.exe
) ELSE (
    echo Error: Executable not found in the application directory.
    exit /b 1
)