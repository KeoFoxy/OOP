@echo off

set QT_VERSION=6.0.3

REM Download the Qt source code
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://download.qt.io/official_releases/qt/%QT_VERSION%/single/qt-everywhere-src-%QT_VERSION%.zip', 'qt-everywhere-src-%QT_VERSION%.zip')"
7z x qt-everywhere-src-%QT_VERSION%.zip
cd qt-everywhere-src-%QT_VERSION%

REM Configure the build with CMake
mkdir build
cd build
cmake .. -G "Ninja" -DCMAKE_INSTALL_PREFIX=C:/Qt/%QT_VERSION% -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=mingw32-g++ -DCMAKE_C_COMPILER=mingw32-gcc -DQT_OPENGL_ES_2=ON -DQT_NO_OPENGL=ON -DQT_NO_OPENGL_ES_2=OFF -DQT_NO_OPENSSL=ON

REM Build Qt using Ninja
ninja
ninja install

REM Build Qt Creator using Ninja
cd ../qt-creator
mkdir build
cd build
cmake .. -G "Ninja" -DCMAKE_INSTALL_PREFIX=C:/Qt/%QT_VERSION% -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=mingw32-g++ -DCMAKE_C_COMPILER=mingw32-gcc
ninja
ninja install
