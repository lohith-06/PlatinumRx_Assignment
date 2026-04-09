
#  01_Time_Converter.py
#  Convert an integer number of minutes to human-readable form

def minutes_to_human(total_minutes):
    if total_minutes < 0:
        raise ValueError('Minutes cannot be negative')

    hours   = total_minutes // 60
    minutes = total_minutes % 60

    if hours > 0 and minutes > 0:
        return f"{hours}hr {minutes}minutes"
    elif hours > 0:
        return f"{hours}hr"
    else:
        return f"{minutes}minutes"




       
mins = int(input())     
print(f"{mins:<15} --> {minutes_to_human(mins)}")
