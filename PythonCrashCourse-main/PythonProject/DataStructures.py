# Lists.
# Tuples.
# Dictionaries.
# Sets."

#A list is an ordered collection of items. Lists are mutable, meaning you can change their contents.
#List allow duplicates
# Creating a list
#fruits=[] #empty list
# fruits = ["apple", "banana", "cherry","apple"]
#
# # Accessing elements
# print(fruits[0])  # First item
# print(fruits[1])  # second item
# print(fruits[-1])  # Last item
#
# # Adding and removing items
# fruits.append("orange")  # Add an item
# print(fruits)
#
# fruits.remove("banana")  # Remove an item
# print(fruits)
#
# # # Iterating over a list / loop through a list
# for fruit in fruits:
#     print(f"I love {fruit}")
#
# #Tuples - are collection of items which is ordered and unchangeable (immutable)
# #Tubles are created using round () bracket


# Creating a tuple
# colors = ("red", "green", "blue")
#
# # Accessing elements
# print(colors[0]) # red
# print(colors[-1])#blue
#
# # Tuples are immutable
# #colors[0] = "yellow"  # This will raise an error
#
# #loop through a tuple
#
# for color in colors:
#     print(color)
#
# #Tuple methods
#
# # count()	Returns the number of times a specified value occurs in a tuple
# my_tuple = (1,3,7,8,5,4,6,8,5)
# x = my_tuple.count(8)
# print(x)
#
# index()	Searches the tuple for a specified value and returns the position of where it was found
# my_tuple = (1,3,7,8,5,4,6,8,5)
# x = my_tuple.index(5)
# print(x)

#dictionary
# A dictionary is a collection of key:value pairs.
#ordered
#changable
#no duplicates
#created using curly{}
#
# # Creating a dictionary
# person = {
#     "name": "Alice",
#     "age": 25,
#     "city": "New York"
# }
#
# # Accessing and updating values
# print(person["name"])
# person["age"] = 26 #update the value of existing key age .
# print(person)
#
# # Adding a new key-value pair
# person["profession"] = "Engineer"
# print(person)
# #
# # # Iterating over a dictionary
# for key, value in person.items():
#     print(f"{key}: {value}")
#
# #Iterate over keys
# for key in person.keys():
#     print(key)
#
# #Iterate over values
# for value in person.values():
#     print(value)
#

# clear method
# person = {
#     "name": "Alice",
#     "age": 25,
#     "city": "New York"
# }
# print(person)
# person.clear()
# print(person)

# #get() methods
# x = person.get("age") #25
# print(x)
#
# #pop() methods
# x = person.pop("age")
# print(x)
# print(person)

#update method
# person.update({"salary":10000}) #insert new item to person dictionary
# print(person)

#Sets
#Set is a collection which is unordered, unchangable and unindeexed.


# Creating a set
# numbers = {1, 2, 3, 3, 4}
#
# print(numbers)  # Duplicates are automatically removed

# Adding and removing items
# numbers.add(5)
# numbers.remove(1)
# print(numbers)

# # Set operations
# numbers = {1, 2, 3, 3, 4}
# even_numbers = {2, 4, 6}
# print(numbers.intersection(even_numbers))  # Common elements
# print(numbers.union(even_numbers))        # All unique elements., duplicates are excluded

# even_numbers = {2, 4, 6}
# # print(even_numbers)
# # even_numbers.clear()
# # print(even_numbers)
#
# #copy method
# copied_set = even_numbers.copy()
# print(copied_set)
#
# #pop() removes random element from the set and returns the removed value
# numbers = {1, 2, 3, 3, 4}
# x = numbers.pop()
# print(x)


#loop through items of sets
numbers = {1, 2, 3, 4}
for x in numbers:
    print(x)



