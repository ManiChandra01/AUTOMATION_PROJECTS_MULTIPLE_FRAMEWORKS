#variables and datatypes
#Basic operations
#Input and output
##comments and code readability

#1. Variables and data types
# name = "Alice"  # String
# age = 25        # Integer
# height = 5.6    # Float
# is_student = True  # Boolean
# #print(type(age))
#
# print(name)
# print(age)
# print(height)
# print(is_student)

#2. Basic Operations
# Arithmetic operations
# a = 10
# b = 3
# print(a + b)  # Addition
# print(a - b)  # Subtraction
# print(a * b)  # Multiplication
# print(a / b)  # Division
# print(a % b)  # Modulus (remainder)

# Logical operations  allow us to combine or modify these truth values
# x = True
# y = False
# print(x and y)  # Logical AND #fale
# print(x or y)   # Logical OR  #true
# print(not x)    # Logical NOT #false

#3.Input and Output
# #input() is used to take user input.
# name = input("Enter your name")
# print(name)
#
# #converting input to other datatypes
# #take integer input from user
# age = int(input("Enter your age:"))
# print(age)
#
# #converting input to float
# height = float(input("Enter height:"))
# print(height)

#output formating using f-string - place variables inside curly braces{} prefixed by f

name ="John"
age=30
height=5.9

#Name:John, Age:30, Height:5.9 ft
print(f"Name:{name},Age:{age},Height:{height} ft")

# The input() function lets you take input as a string.
# To convert the input to a number, use int() or float().
# The f-string syntax makes it easy to format strings and include variables."

#comment and code readabitly - comments are ignore by Python when running your code

#Use # for single-line comments.
#Use triple quotes (''' or """) for multi-line comments

#this is single line comment
"""this is multiline comment
second line
it can span multiple line"""

#Naming convention
#variables and function - use snake_case
#example user_name, calculate_total
#constants-UPPER_SNAKE_CASE EX: MAX_LIMIT, PI, GRAVITY
#Classes- CamelCase Ex: StudentProfile
