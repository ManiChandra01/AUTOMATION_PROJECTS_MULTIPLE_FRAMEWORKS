# Conditional statements.
# Logical operators.
# Loops: for and while.
# Break and continue statements."

#conditional statement
#Always ensure proper indentation for clean , error-free code.
# age = int(input("Enter your age: "))  #getting user input
# if age < 18:
#     print("You are a minor.")
# elif age >= 18 and age < 60:
#     print("You are an adult.")
# else:
#     print("You are a senior.")


# Logical operators
# and: Both conditions must be true.
# or: At least one condition must be true.
# # not: Reverses a condition."
#
# is_student = True #the person is a student
# has_id = True #no ID
#
# if is_student and has_id:
#     print("You are eligible for a student discount.")
# elif is_student or has_id:
#     print("You might be eligible for a partial discount.")
# else:
#     print("You are not eligible for a discount.")
#
# # For loop
# for i in range(5):  # Loops from 0 to 4
#     print(f"Iteration {i}")
#
# # While loop
# count = 0
# while count < 5:
#     print(f"Count is {count}")
#     count += 1 #count = count+1
#
# # Use for loops when you know the number of iterations.
# # Use while loops when the iterations depend on a condition."
#
# #break
# for i in range(10):
#     if i == 5:
#         break  # Stops the loop when i equals 5
#     print(i)

#continue
for i in range(10):
    if i == 5:
        continue  # skip the number 5
    print(i)










