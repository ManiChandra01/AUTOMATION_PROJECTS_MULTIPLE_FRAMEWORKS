#Game Logic
# The program will generate a random number between 1 and 100.
# The user will input guesses,
# and the program will tell them if their guess is too high, too low, or correct.
# We’ll keep track of the number of attempts the user makes."

import random
#Generate random number between 1 and 100
number_to_guess = random.randint(1,100)
attempts =0

#welcome message
print("Welcome to the Number Guessing Game!")
print("I m thinking of a number between 1 and 100")

while True:
    guess =int(input("Enter your guess:"))
    attempts=attempts+1
   # attempts+=1

    #checking the guess

    if guess < number_to_guess:
        print("Too low! Try again.")
    elif guess > number_to_guess:
        print("Too high! Try again.")
    else:
        print(f"Congratulations! you have guessed the number in {attempts} attempts")
        break
