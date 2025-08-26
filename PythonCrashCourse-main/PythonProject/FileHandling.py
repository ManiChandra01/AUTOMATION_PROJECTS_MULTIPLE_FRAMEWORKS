import os
# File handling is essential for reading from and writing to external files.
# In this section, we’ll cover:
# Opening and closing files.
# Reading from files.
# Writing to files.
# File modes and error handling."
# delete a file

#open file using open()

# Opening a file
#file open modes for open() method
# 'r': read mode
# 'w':write mode(overwrites the file)
# 'a':append mode(adds to the end of the file)
# 'r+':Read and write mode

# # file = open("example.txt", "r")  # 'r' is for read mode
# #relative path
# #file = open("MyFileFolder/example.txt", "r")  # 'r' is for read mode
# #full path/absolute path
# file = open("c:/example2.txt", "r")  # 'r' is for read mode
#
# # Reading from the file
# content = file.read()  # Read the entire content of the file
# print(content)
#
# # Closing the file
# file.close()

#Reading from files
# Python provides several ways to read from a file:

# read(): Reads the entire file as a single string.
# readline(): Reads one line at a time
# readlines(): Reads all lines as a list

#open the file
file = open("example.txt", "r")  # 'r' is for read mode

# Read one line
# file.seek(0)  # Move the pointer back to the start
# line = file.readline() #first line is read
# print(line)
# line = file.readline() #second line is read
# print(line)

# content = file.read()
# print(content)
# #close the file
# file.close()

#
# # Read all lines
file.seek(0)  # Move the pointer back to the start
lines = file.readlines()
print(lines)

# Usage
# -----
# Use read() for small files or when you need everything at once.
# Use readline() or readlines() when you want to process the file line by line.

#Writing to Files

#'w' for write (creates a new file or overwrites an existing one).
#'a' for append (adds to an existing file).

# Writing to a file
# file = open("output.txt", "w")
#
# file.write("Hello, this is a test.\n")
# file.write("Python file handling is easy!")

# file = open("output.txt", "a")
# file.write("Adding a new line\n")
#file.close()

#using with statement
with open("output.txt","w") as file:
    file.write("Hello, this is a test.\n")
    file.write("Python file handling is easy!")

#Error Handling using try-except block
try:
    file = open("nonexistent.txt", "r")
    content = file.read()
    print(content)
except FileNotFoundError:
    print("File not found! Please check the file path.")
finally:
    file.close()

# Delete a file - you must import OS Module and run its os.remove() method
os.remove("output.txt")
