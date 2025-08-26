# Defining and calling functions.
# Function arguments and return values.
# Scope of variables in functions."

#"A function is a block of reusable code that performs a specific task.
# Defining a function
def greet():
    print("Hello, welcome to Python programming!")

# Calling the function
greet()


# Function with arguments
#Functions can take inputs, called arguments, to perform tasks dynamically.

def greet_user(name): #name is a parameter
    print(f"Hello, {name}! Welcome to Python.")

#calling function
greet_user("Alice") #Alice is an argument
greet_user("Bob")


# Returning Values
# Functions can also return values to the caller.

# Function that returns a value
def add_numbers(a, b):
    return a + b

#callling function add_numbers
result = add_numbers(5, 3)
print(f"The sum is: {result}")

#variable scope in functions
# Variables defined inside a function have local scope,
# meaning they can only be used within that function.

length = 5  # global variable

# Local scope
def calculate_area():

    width = 3   # Local variable
    return length * width #funtion ends

print(calculate_area())
print(length)  # This will raise an error
