

# luis arandas 26-02-2023
# simple scons script to compile imgui cross platform, need to try glfw local

import os
import subprocess
import platform
import shutil

system_name = platform.system()

## get compiler path and decode it as string

if system_name == 'Windows':
    result = subprocess.run(['where', 'g++.exe'], stdout=subprocess.PIPE)
    compiler_path = result.stdout.strip().decode()
else:
    result = subprocess.run(['which', 'g++'], stdout=subprocess.PIPE)
    compiler_path = result.stdout.strip().decode()

print("compiler is at -> ", compiler_path)

## setup scons environment

env = Environment()
cxx = result.stdout.strip().decode() # 'g++', 'clang++'

executable = 'scons-imgui-example'

current_folder = os.getcwd()
src_folder = os.path.join(current_folder, 'src')
libs_folder = os.path.join(current_folder, 'libs')
build_folder = os.path.join(current_folder, 'build')
data_folder = os.path.join(current_folder, 'data')
dist_folder = os.path.join(current_folder, 'application')
stb_folder = os.path.join(current_folder, 'libs', 'stb')
imgui_folder = os.path.join(current_folder, 'libs', 'imgui')
imgui_backends_folder = os.path.join(current_folder, 'libs', 'imgui_backends')

## start cleaning previous builds

if os.path.exists(dist_folder):
    os.system('rm -rf ' + dist_folder)

if os.path.exists(build_folder):
    os.system('rm -rf ' + build_folder)

for folder in [build_folder, dist_folder]:
    if not os.path.exists(folder):
        os.makedirs(folder)

## include system libs and flags

if system_name == 'Linux':
    libs = env.ParseConfig('pkg-config --static --libs glfw3')
    env.Append(LIBS=libs, CXXFLAGS=env.ParseConfig('pkg-config --cflags glfw3'))
    env.Append(LIBS='-lGL')

elif system_name == 'Darwin':
    libs = ['-framework', 'OpenGL', '-framework', 'Cocoa', '-framework', 'IOKit', '-framework', 'CoreVideo', '-L/usr/local/lib', '-L/opt/local/lib', '-L/opt/homebrew/lib', '-lglfw']
    env.Append(LIBS=libs, CXXFLAGS=['-I/usr/local/include', '-I/opt/local/include', '-I/opt/homebrew/include'])
    
# elif system_name == 'Windows':
    # # need fix with dll paths, mingw not functional
    # env['CXXCOM'] = '$CXX -c $CXXFLAGS $CPPFLAGS $_CPPDEFFLAGS $_CPPINCFLAGS -o $TARGET $SOURCES'
    # env['CXXFLAGS'] = [x for x in env['CXXFLAGS'] if x != '/TP'] # remove /TP flag
    # mingw_path = os.path.dirname(compiler_path)
    # print("if needed to attach dlls -> ", mingw_path)
    # # if using global do pkg-config
    # # env.Append(LIBS='-lglfw3 -lgdi32 -lopengl32 -limm32')
    # # env.Append(CXXFLAGS=env.ParseConfig('pkg-config --cflags glfw3')) # needed if glfw not local

## create objects from sources

cpp_sources = [
    os.path.join(src_folder, 'main.cpp'),
    os.path.join(imgui_folder, 'imgui.cpp'),
    os.path.join(imgui_folder, 'imgui_demo.cpp'),
    os.path.join(imgui_folder, 'imgui_draw.cpp'),
    os.path.join(imgui_folder, 'imgui_tables.cpp'),
    os.path.join(imgui_folder, 'imgui_widgets.cpp'),
    os.path.join(imgui_backends_folder, 'imgui_impl_glfw.cpp'),
    os.path.join(imgui_backends_folder, 'imgui_impl_opengl3.cpp'),
]

object_arr = []

for cpp_source in cpp_sources:
    object_file = os.path.join(build_folder, os.path.splitext(os.path.basename(cpp_source))[0] + '.o')
    object_arr.append(object_file)
    env.Object(
        target = object_file,
        source = cpp_source,
        CXX = cxx,
        CXXFLAGS = ['-std=c++17', '-I' + imgui_folder, '-I' + imgui_backends_folder, '-I' + build_folder, '-g', '-Wall', '-Wformat']
    )

## run compiler command

def create_shell_script(file_path):
    with open(file_path, 'w') as f:
        f.write("#!/bin/bash\n\n")
        f.write("cp -r data $HOME/\n")
        f.write(f"echo 'Installation of {executable} is successful. You can now run this app from anywhere on the computer. Copied the data folder with fonts and images to $HOME/.'\n")



def post_build_action(target, source, env):

    # def generate_simple_distribution():
    # def generate_documentation():

    try:
        shutil.move(executable, dist_folder)
        print(f"File '{executable}' moved to '{dist_folder}' successfully.")
    except FileNotFoundError:
        print(f"File '{executable}' not found.")
    except PermissionError:
        print(f"Permission denied. Failed to move file '{executable}'.")

    # copy files for installation

    try:
        shutil.copytree(data_folder, os.path.join(dist_folder, 'data'))
        print("Folder 'data/' copied to the destination directory successfully.")
    except FileNotFoundError:
        print("Folder 'data/' not found.")
    except PermissionError:
        print("Permission denied. Failed to copy folder 'data/'.")

    # create install file and save it there
    create_shell_script(os.path.join(dist_folder, 'install.sh'))
        


if system_name == 'Linux':
    del env['LIBS'][-2] 
    # removing scons object from array as becomes unhashable on linux (somehow)
    env.Append(CPPPATH = stb_folder) # add to CCFLAGS if not working
    application = env.Program(target = executable, source = object_arr, LIBS = env['LIBS'])
    env.AddPostAction(application, post_build_action)
    


elif system_name == 'Darwin':
    env.Append(CPPPATH = stb_folder)
    env.Program(target = executable, source = object_arr, LIBS = env['LIBS'])

# elif system_name == 'Windows':
# using local glfw headers
    #env['CXXCOM'] = '$CXX -c $CXXFLAGS $CPPFLAGS $_CPPDEFFLAGS $_CPPINCFLAGS -o $TARGET $SOURCES'
    #env['CXXFLAGS'] = [x for x in env['CXXFLAGS'] if x != '/TP'] # remove /TP flag
    #mingw_path = os.path.dirname(compiler_path)
    #print("if needed to attach dlls -> ", mingw_path)
    # if using global use pkg-config
    # env.Append(LIBS='-lglfw3 -lgdi32 -lopengl32 -limm32')
    # env.Append(CXXFLAGS=env.ParseConfig('pkg-config --cflags glfw3')) # needed if glfw not local
#     # os.chdir(build_folder)
#     env.Program(target=executable, source=objs)

## setup quick distribution




# dist_path = 'dist/' + executable
# # Create the 'dist/' directory if it doesn't exist
# env.Command('dist', '', env.Mkdir('$TARGET'))
# # Create the 'dist/' + example_target directory if it doesn't exist
# env.Command(dist_path, '', env.Mkdir('$TARGET'))
# # Use Command to copy the file
# env.Command(dist_path + '/' + example_target, example_target, Copy("$TARGET", "$SOURCE"))

# env.Command(dist_folder, executable, Copy("$TARGET", "$SOURCE"))

# Exit(0) # allows arguments
