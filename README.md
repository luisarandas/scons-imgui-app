# scons-imgui-app

Simple cross platform ImGui application compiling with Scons. Tested on 1) Ubuntu 22.04, 2) Windows 11. Includes STD single header libraries and GLFW from pkg-config. To be used in Docker/Podman with: https://github.com/luisarandas/docker-scons-imgui-app with OS-specific installation.

<!-- ![capture](ubuntu/capture20240228.png) -->
<img src="ubuntu/capture20240228.png" alt="capture" width="70%" />

##### Commands
```
(For Ubuntu:)
$ sudo apt-get install libglfw3 libglfw3-dev
$ sudo apt-get install scons
$ scons --clean
$ scons
$ sudo chmod +x ./application/install.sh && ./application/install.sh
$ ./ubuntu/application/scons-imgui-app
```

```
(For MacOS probably will need:)
brew install glfw
brew install scons
```

```
(Fow Windows probably will need:)
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
