'''
remove_digit() takes two string arguments: number and digit
and returns the resulting string after removing exactly
one occurrence of digit from number such that the value of the resulting string in decimal form is maximized
'''

def remove_digit(number: str, digit: str) -> str:
    max_number = number.replace(digit, '', 1)
    for i in range(1, len(number)):
        if number[i] == digit:
            new_number = number[:i] + number[i+1:]
            if int(new_number) > int(max_number):
                max_number = new_number
    return max_number


# test cases

number = "1231"
digit = "1"
result = remove_digit(number, digit)
print(result)  


# Output: "231"
# 
