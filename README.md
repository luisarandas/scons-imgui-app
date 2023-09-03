# scons-imgui-example

simple cross platform scons pipeline to build imgui applications<br>
targeting development on reimaged computers and currently compiles on ubuntu 22.04, MacOS Monterey 12.2<br>

includes some single-header public domain libraries for functions e.g.,image loading, writing and resizing. also included glfw for local reference

## linux installation <br>

**[needed system libs]**<br>
```
sudo apt-get install libglfw3 libglfw3-dev
sudo apt-get install scons
```
**[compilation commands]**<br>
```
cd xyz/scons-imgui-example
scons
(scons --clean) to remove targets
```

[**in review from here**]

## macos installation <br>

**[needed system libs]**<br>
```
brew install glfw
brew install scons
```
**[compilation commands]**<br>
```
scons
(scons --clean) to remove targets
```

## windows installation <br>

**[needed system libs]**<br>
**[python, glfw and mingw]**<br>
```
curl -O https://www.python.org/ftp/python/3.11.2/python-3.11.2-amd64.exe
(install in C:\)
setx PATH "%PATH%;C:\Python"
setx PATH "%PATH%;C:\Python\Scripts"
pip install scons
curl -O https://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz
tar -xf pkg-config-0.29.2.tar.gz
move "pkg-config-0.29.2.tar.gz" "C:\pkg-config"
setx PATH "%PATH%;C:\pkg-config"
curl -O https://osdn.net/projects/mingw/downloads/68260/mingw-get-setup.exe/
(mark mingw32-gcc-g++-bin for installation, apply changes)
setx PATH "%PATH%;C:\MinGW\bin"
pacman -Syu (on freshly opened terminal)
pacman -S mingw-w64-x86_64-toolchain (on MinGW-w64)
```
**[compilation commands]**<br>
```
scons
(scons --clean) to remove targets
```