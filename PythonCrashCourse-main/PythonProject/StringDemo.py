# Creating and manipulating strings
# String methods and operations
# String formatting

# Creating strings
single_quote = 'Hello'
double_quote = "Hello"
multi_line = """This is a 
multi-line string."""
print(single_quote)
print(double_quote)
print(multi_line)

#Access chracters in a string using indexing and slicing

#indexing
text = "Python"
print(text[0] ) #First ccharacter (P)
print(text[-1] )#Last character (n)

#slicing method to extract parts of the string
#string[start:end]

print(text[0:3]) #substring Pyt
print(text[:4]) #substring Pyt
print(text[1:]) #substring Pyt

#String Methods
text = "hello world"
print(text.upper())
print(text.lower())
print(text.capitalize())

text2="   hello   "
print(text2.strip())

text3 = "Hello, Python world"
print(text3.split(",") )#['Hello, 'Python World']

#String concatenation using + operator
greeting= "Hello"
name = "Amit"
message = greeting +" " + name
print(message)

#Repeat the string using * operator
repeat = "Hi! " * 3
print(repeat)

#String formatting using f-string
name = "Prachi"
age = 36
message = f"Hello, my name is {name} and I am {age} years old."
print(message)

#Len() functions- returns no. of characters in a string
text = "Hello"
print(len(text))

#Escape characters
#Ex. to add new line (\n)
text ="Hello\nWorld" #create a new line
print(text)

quote = "He said, \"Python is amazing\"" #escape character (\)
print(quote)

#Alternative to escape character \
quote = 'He said, "Python is amazing"' #escape character (\)
print(quote)

#checking substrings - use in keyword
text = "I love Python" #main / large
print("love" in text) #true
print("java" in text) #false
















