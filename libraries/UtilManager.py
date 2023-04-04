def check_string_contains(main_string):
    if main_string.count('ROOT') >= 1 or main_string.count('CHILD') == 0:
        return True
    elif main_string.count('ROOT') == 0 or main_string.count('CHILD') >= 1:
        return False
