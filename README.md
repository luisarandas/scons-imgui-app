# scons-imgui-app

Simple cross platform ImGui application compiling with Scons. Tested on 1) Ubuntu 22.04, 2) Windows 11. Includes STD single header libraries and GLFW from pkg-config/local and backends. To be used in Docker/Podman with: https://github.com/luisarandas/docker-scons-imgui-app.

<!-- ![capture](ubuntu/capture20240228.png) -->
<img src="ubuntu/capture20240228.png" alt="capture" width="70%" />

##### Commands
```
(For Ubuntu and Windows:)
$ scons --clean
$ scons
(Exports to:)
$ ./ubuntu/application/scons-imgui-app
$ ./windows/application/scons-imgui-app.exe
```
