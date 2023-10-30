# Import the re module 
import re
# Define a function to validate the password
def validate_password(password):
    # Check the length of the password
    if len(password) < 6 or len(password) > 12:
        return False
    # Check if the password contains at least one letter between [a-z]
    if not re.search("[a-z]", password):
        return False
    # Check if the password contains at least one number between [0-9]
    if not re.search("[0-9]", password):
        return False
    # Check if the password contains at least one letter between [A-Z]
    if not re.search("[A-Z]", password):
        return False
    # Check if the password contains at least one character from [$#@_&%]
    if not re.search("[$#@_&%]", password):
        return False
    # If all the conditions are satisfied, return True
    return True

# Input a password
password = input("Enter a password:")

# Call the function to validate the password and print the result
if validate_password(password):
    print("Valid password")
else:
    print("Invalid password")
