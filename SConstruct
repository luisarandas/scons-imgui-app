

# luis arandas 26-02-2023
# simple scons script to compile imgui cross platform, need to try glfw local

import os
import subprocess
import platform
system_name = platform.system()

# get compiler path and decode it as string

if system_name == 'Windows':
    result = subprocess.run(['where', 'g++.exe'], stdout=subprocess.PIPE)
    compiler_path = result.stdout.strip().decode()
else:
    result = subprocess.run(['which', 'g++'], stdout=subprocess.PIPE)
    compiler_path = result.stdout.strip().decode()

print("compiler is at -> ", compiler_path)

# setup scons environment

env = Environment()
cxx = result.stdout.strip().decode() # 'g++', 'clang++'

executable = 'scons-imgui-example'

current_folder = os.getcwd()
src_folder = os.path.join(current_folder, 'src')
libs_folder = os.path.join(current_folder, 'libs')
build_folder = os.path.join(current_folder, 'build')
stb_folder = os.path.join(current_folder, 'libs', 'stb')
imgui_folder = os.path.join(current_folder, 'libs', 'imgui')
imgui_backends_folder = os.path.join(current_folder, 'libs', 'imgui_backends')

if not os.path.exists(build_folder):
    os.makedirs(build_folder)

if system_name == 'Linux':
    libs = env.ParseConfig('pkg-config --static --libs glfw3')
    env.Append(LIBS=libs, CXXFLAGS=env.ParseConfig('pkg-config --cflags glfw3'))
    env.Append(LIBS='-lGL')

elif system_name == 'Darwin':
    libs = ['-framework', 'OpenGL', '-framework', 'Cocoa', '-framework', 'IOKit', '-framework', 'CoreVideo', '-L/usr/local/lib', '-L/opt/local/lib', '-L/opt/homebrew/lib', '-lglfw']
    env.Append(LIBS=libs, CXXFLAGS=['-I/usr/local/include', '-I/opt/local/include', '-I/opt/homebrew/include'])
    
elif system_name == 'Windows':
    # need fix with dll paths, mingw not functional
    env['CXXCOM'] = '$CXX -c $CXXFLAGS $CPPFLAGS $_CPPDEFFLAGS $_CPPINCFLAGS -o $TARGET $SOURCES'
    env['CXXFLAGS'] = [x for x in env['CXXFLAGS'] if x != '/TP'] # remove /TP flag
    mingw_path = os.path.dirname(compiler_path)
    print("if needed to attach dlls -> ", mingw_path)
    # if using global do pkg-config
    # env.Append(LIBS='-lglfw3 -lgdi32 -lopengl32 -limm32')
    # env.Append(CXXFLAGS=env.ParseConfig('pkg-config --cflags glfw3')) # needed if glfw not local

sources = [
    os.path.join(src_folder, 'main.cpp'),
    os.path.join(imgui_folder, 'imgui.cpp'),
    os.path.join(imgui_folder, 'imgui_demo.cpp'),
    os.path.join(imgui_folder, 'imgui_draw.cpp'),
    os.path.join(imgui_folder, 'imgui_tables.cpp'),
    os.path.join(imgui_folder, 'imgui_widgets.cpp'),
    os.path.join(imgui_backends_folder, 'imgui_impl_glfw.cpp'),
    os.path.join(imgui_backends_folder, 'imgui_impl_opengl3.cpp'),
]

objs = []
for source in sources:
    obj = os.path.join(build_folder, os.path.splitext(os.path.basename(source))[0] + '.o')
    objs.append(obj)
    env.Object(
        target=obj,
        source=source,
        CXX=cxx,
        CXXFLAGS=['-std=c++17', '-I' + imgui_folder, '-I' + imgui_backends_folder, '-I' + build_folder, '-g', '-Wall', '-Wformat']
        # CCFLAGS=['-std=c++17', '-I' + imgui_folder, '-I' + imgui_backends_folder, '-I' + build_folder, '-g', '-Wall', '-Wformat']
        # CPPPATH=[imgui_folder, imgui_backends_folder, build_folder, stb_folder, glfw_folder], OBJECTPREFIX='', OBJECTSUFFIX='.o', CPPSUFFIX='.cpp', SHCCFLAGS='')
    )

# run compiler command

if system_name == 'Linux':
    del env['LIBS'][-2] # removing scons object from array as becomes unhashable on linux
    print("LIBS: ", env['LIBS'])
    env.Append(CPPPATH=stb_folder) # add to CCFLAGS if not working
    env.Program(target=executable, source=objs, LIBS=env['LIBS'])

elif system_name == 'Darwin':
    env.Append(CPPPATH=stb_folder) # can for loop array in future
    env.Program(target=executable, source=objs, LIBS=env['LIBS'])

elif system_name == 'Windows':
    # os.chdir(build_folder)
    env.Program(target=executable, source=objs)