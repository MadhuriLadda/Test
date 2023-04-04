import datetime
import random
import string
import uuid


def Random_Firstname(length=6):
    letters = string.ascii_lowercase
    str_val = ''.join(random.choice(letters) for i in range(length))
    return str_val


def Random_lastname(length=6):
    letters = string.ascii_lowercase
    str_val = ''.join(random.choice(letters) for i in range(length))
    return str_val


def Random_mail():
    firstname = Random_Firstname(8)
    lastname = Random_lastname(8)
    mail_id = firstname + lastname + "@gmail.com"
    return mail_id


def Random_Building_Number():
    firstname = Random_String_In_Upper(1)
    val = random.randint(1, 99)
    building_Number = firstname + "-" + str(val)
    return building_Number


def Random_String_In_Upper(length=4):
    str_val = ''.join(random.choice(string.ascii_letters) for i in range(length))
    return str_val.upper()


def Random_Number(minRange=0, maxRange=9999999999):
    val = random.randint(minRange, maxRange)
    return val


def Random_MobileNumber(length=9):
    val = 0
    if length == 9:
        val = random.randint(345000011, 999999999)
    elif length == 10:
        val = random.randint(6450000110, 9999999999)
    else:
        minVal = int("7" * length)
        maxVal = int("9" * length)
        val = random.randint(minVal, maxVal)
    return val


def Random_UUID():
    return uuid.uuid4()


def Random_Date():
    getToday = datetime.datetime.today().strftime('%Y')
    getMonthAndDate = datetime.datetime.today().strftime('-%m-%d')
    year = random.randint((int(getToday) - 53), (int(getToday) - 21))
    dob = str(year) + getMonthAndDate
    return dob


def getCustomFormatDate(dateFormat='%y%m%d'):
    getToday = datetime.datetime.today().strftime(dateFormat)
    return getToday


def RandomColor():
    colorList = ['black', 'silver', 'gray', 'white', 'maroon', 'red', 'purple', 'green', 'lime', 'olive', 'yellow',
                 'blue']
    return random.choice(colorList)


def RandomGender():
    genderList = ['Male', 'FeMale']
    return random.choice(genderList)


def Random_IBAN(countryCode, iban=None):
    iban
    if countryCode == 'DE':
        two_Digits_random = str(Random_Number(11, 97))
        bankNumber = "37040044"
        four_Digits_random = str(Random_Number(11, 97))
        iban = countryCode + two_Digits_random + bankNumber + getCustomFormatDate() + four_Digits_random
        print(iban)
        return iban
    elif countryCode == 'FR':
        two_Digits_random = str(Random_Number(11, 97))
        branchNumber = str(Random_Number(11111, 99999))
        bankNumber = str(Random_Number(11111, 99999))
        seven_Digits_random = str(Random_Number(1111111, 9999999))
        iban = countryCode + two_Digits_random + branchNumber + bankNumber + getCustomFormatDate() + seven_Digits_random
        print(iban)
        return iban
    elif countryCode == 'NL':
        two_Digits_random = str(Random_Number(11, 97))
        four_Digits_random = str(Random_Number(1111, 9999))
        iban = countryCode + two_Digits_random + Random_String_In_Upper() + getCustomFormatDate() + four_Digits_random
        print(iban)
        return iban
    elif countryCode == 'BE':
        two_Digits_random = str(Random_Number(10, 97))
        six_Digits_random = str(Random_Number(111111, 999999))
        iban = countryCode + two_Digits_random + getCustomFormatDate() + six_Digits_random
        print(iban)
        return iban
    return iban


def Random_UniqueNumber():
    return datetime.datetime.today().strftime('%y%m%d%H%M%f')

