
#  02_Remove_Duplicates.py
#  Remove duplicate characters from a string using a loop



def remove_duplicates(s):
    result = ""                  # will hold the unique output string

    for char in s:               # loop through every character
        if char not in result:   # only add if not already seen
            result += char

    return result


s=input()

print(f"{repr(s):<20} {repr(remove_duplicates(s))}")
