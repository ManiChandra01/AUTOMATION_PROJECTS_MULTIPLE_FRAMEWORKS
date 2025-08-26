# import math
#
# print(math.sqrt(16))  # Square root
# print(math.factorial(5))  # Factorial 5!=5*4*3*2*1=120
# print(math.pi)  # Value of pi = 3.14
#
#
# import random
#
# print(random.randint(1, 100))  # Random integer between 1 and 100
# print(random.choice(['apple', 'banana', 'cherry']))  # Random item from a list

import datetime

now = datetime.datetime.now()
print(now)  # Current date and time
print(now.year)  # Current year
print(now.strftime("%Y-%m-%d %H:%M:%S"))  # Formatting the date

# %Y: Full year (e.g., 2025).
# %m: Month as a zero-padded number (e.g., 01 for January).
# %d: Day of the month as a zero-padded number (e.g., 28).
# %H: Hour in 24-hour format (e.g., 15 for 3 PM).
# %M: Minutes (e.g., 15).
# %S: Seconds (e.g., 42).

#installing and using external modules

import requests

response = requests.get("https://api.github.com")
print(response.status_code)  # Check the status of the response
print(response.json())  # Print the response data in JSON format
