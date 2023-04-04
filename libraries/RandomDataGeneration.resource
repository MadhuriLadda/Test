*** Settings ***
Documentation    Fake Data API
Library          ./RandamDataLibrary.py
Library          ./DateLibrary.py
Library          ./UtilManager.py
Library          Collections
Library          String
Library          DateTime

*** Variables ***
${uuid} =
${color} =
${unique_number} =
${first_name} =
${cntr_dob} =
${color} =
${building_number} =
${box_number} =
${street_name} =
${uuid} =
${iban1} =
${iban2} =
${iban3} =
${iban4} =
${iban5} =
${iban6} =
${mobile_number} =


*** Keywords ***
Contract Creation Json Data Preparation
    [Arguments]   ${countryCode}
    Generate UUID
    Generate Color
    Generate unique number
    Generate First Name
    Generate Building Number
    Generate Box Number
    Generate DOB
    Generate Street Name
    Generate IBAN1    ${countryCode}
    Generate IBAN2    ${countryCode}
    Generate IBAN3    ${countryCode}
    Generate IBAN4    ${countryCode}
    Generate Mobile Number      9


Add Account and Contract To Contract json Data Preparation
    [Arguments]   ${countryCode}
    Generate First Name
    Generate Building Number
    Generate DOB
    Generate Street Name
    Generate IBAN5    ${countryCode}
    Generate IBAN6    ${countryCode}

Generate UUID
    ${random_uuid}=    RandamDataLibrary.Random UUID
    set global variable    ${uuid}      ${random_uuid}

Generate Color
    ${random_color}=    RandamDataLibrary.RandomColor
    set global variable    ${color}      ${random_color}

Generate unique number
    ${random_unique_number}=    RandamDataLibrary.Random UniqueNumber
    set global variable    ${unique_number}      ${random_unique_number}

Generate First Name
    ${random_firstname}=    generate random string    12     [UPPER]
    set global variable    ${first_name}      ${random_firstname}

Generate Building Number
    ${random_Building}=    RandamDataLibrary.Random Building Number
    set global variable    ${building_number}      ${random_Building}

Generate Box Number
    ${random_box_number}=    RandamDataLibrary.Random Building Number
    set global variable    ${box_number}      ${random_box_number}

Generate DOB
    ${random_dob}=    RandamDataLibrary.Random Date
    set global variable    ${cntr_dob}      ${random_dob}

Generate Street Name
    ${random_Street}=    generate random string    6     UPPER
    set global variable    ${street_name}      ${random_Street}

Generate IBAN1
    [Arguments]    ${countryCode}
    ${random_iban1}=    RandamDataLibrary.Random IBAN   ${countryCode}
    set global variable    ${iban1}      ${random_iban1}

Generate IBAN2
    [Arguments]    ${countryCode}
    ${random_iban2}=    RandamDataLibrary.Random IBAN   ${countryCode}
    set global variable    ${iban2}      ${random_iban2}

Generate IBAN3
    [Arguments]    ${countryCode}
    ${random_iban3}=    RandamDataLibrary.Random IBAN   ${countryCode}
    set global variable    ${iban3}      ${random_iban3}

Generate IBAN4
    [Arguments]    ${countryCode}
    ${random_iban4}=    RandamDataLibrary.Random IBAN   ${countryCode}
    set global variable    ${iban4}      ${random_iban4}

Generate IBAN5
    [Arguments]    ${countryCode}
    ${random_iban5}=    RandamDataLibrary.Random IBAN   ${countryCode}
    set global variable    ${iban5}      ${random_iban5}

Generate IBAN6
    [Arguments]    ${countryCode}
    ${random_iban6}=    RandamDataLibrary.Random IBAN   ${countryCode}
    set global variable    ${iban6}      ${random_iban6}

Generate Mobile Number
    [Arguments]    ${length}
    ${random_mbno}=    RandamDataLibrary.Random MobileNumber    ${length}
    set global variable    ${mobile_number}      ${random_mbno}

Generate ParisCurrentTime
    ${isoTimestamp}=    DateLibrary.getCurrentTime
    set global variable    ${paris_current_date_time}      ${isoTimestamp}


Generate Test Case Unique Number
    ${currentDate}    Get Current Date    UTC    result_format=%d%m%y%H%M%S%f
    [Return]    ${currentDate}

Check Is Root Account tempate references
    [Arguments]                 ${string_ref}
    ${is_root_account_ref}      UtilManager.check string contains       ${string_ref}
    [Return]                    ${is_root_account_ref}