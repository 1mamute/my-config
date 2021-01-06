import platform
import sys
import os
import pathlib
import argparse

kernel = platform.system() # Type of OS
dist = platform.release() # Distribution of the OS
repo_path = pathlib.Path(__file__).parent.absolute() # Full path where the scripts is located

# Initialize argument parser
parser = argparse.ArgumentParser()
parser.parse_args()

try:
  # The first argument is the directory the user wants to copy
  # the configuration files
  dir = sys.argv[1]
except:
  # If there's no directory provided, extract the configuration 
  # files to the user's home directory
  # TODO: Get user home directory
  dir = "/home/gb/"

# Only for Linux/GNU
print("Kernel: " + kernel)
if kernel != "Linux":
  print("This script only works in Linux/GNU")
  exit

# Check release of OS
print("OS: " + dist)

# List recursively all files in this repository
dir_list = [] # List of directories
file_list = [] # List of files in the repository folder
dir_list = os.listdir(repo_path)

for i in dir_list:
  if os.path.isfile(repo_path.joinpath(i)) and i != "README.md" and i != sys.argv[0]:
    file_list.append(i)
    print(repo_path.joinpath(i))
print("There is " + str(len(file_list)) + " files in " + str(repo_path))

# Python doesn't have a switch statement, you have to create a function 
# I'm doing a if tree for now just to get it working
# TODO: use a switch statement (https://data-flair.training/blogs/python-switch-case/)
if dist.upper().find("MANJARO") or dist.upper().find("ARCH") or dist.upper().find("ARCO") or dist.upper().find("ARTIX"):
  print("Initializing configuration for arch-based systems...")
elif dist.upper().find("DEBIAN") or dist.upper().find("UBUNTU") or dist.upper().find("MX"):
  print("Initializing configuration for debian-based systems...")
elif dist.upper().find("FEDORA") or dist.upper().find("REDHAT") or dist.upper().find("CENTOS"):
  print("Initializing configuration for redhat-based systems...")
