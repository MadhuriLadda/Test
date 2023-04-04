*** Settings ***
Documentation       Contract Creation API

Library             REST    ssl_verify=false
Library             RequestsLibrary
Library             Collections
Library             String
Library             JSONLibrary
Resource            ../common/AuthenticationApi.resource
Resource            ../../../../libraries/RandomDataGeneration.resource

*** Variables ***
${response_print_in_console} =
${BASE_API_URL}
&{cntr_res_data}
${prduct_config_file}
&{product_config_templates}
${issuerId}
# ContractCreationAPI.resource

*** Keywords ***
Run IBO Contract Cration API
    [Documentation]     /issuers/{issuerId}/contracts/create-consumer-contract
    set basic Authentication
    ${JSON_FILE}=                                           Contract Creation Request data
    REST.POST
    ...  ${BASE_API_URL}/issuers/${issuerId}/contracts/create-consumer-contract    body=${JSON_FILE}
    REST.Output                                             response body          also_console=${response_print_in_console}
    # ******** Verification *******
    Integer                                                 response status        200
    ${response}                                             REST.Output            response body                                also_console=False
    ${test_contractReference}=                              get value from json    ${response}                                  $.data.contract.contractIdentifier.contractReference
    ${test_issuerContractExternalReference}=                get value from json    ${response}                                  $.data.contract.contractIdentifier.issuerContractExternalReference
    ${test_cardContractReference}=                          get value from json    ${response}                                  $.data.contract.cardContracts[0].cardContractIdentifier.cardContractReference
    ${test_issuerCardContractExternalReference}=            get value from json    ${response}                                  $.data.contract.cardContracts[0].cardContractIdentifier.issuerCardContractExternalReference
    ${test_customerReference}=                              get value from json    ${response}                                  $.data.contract.contractOwnerIdentifier.customerReference
    ${test_issuerCustomerExternalReference}=                get value from json    ${response}                                  $.data.contract.contractOwnerIdentifier.issuerCustomerExternalReference
    ${test_firstName}=                                      get value from json    ${response}                                  $.data.customers[0].firstName
    ${test_lastName}=                                       get value from json    ${response}                                  $.data.customers[0].lastName
    ${test_cardReference}=                                  get value from json    ${response}                                  $.data.contract.cardContracts[0].card.cardIdentifier.cardReference
    ${test_issuerCardExternalReference}=                    get value from json    ${response}                                  $.data.contract.cardContracts[0].card.cardIdentifier.issuerCardExternalReference
    ${test_pan}=                                            get value from json    ${response}                                  $.data.contract.cardContracts[0].card.pan
    ${test_expiryDate}=                                     get value from json    ${response}                                  $.data.contract.cardContracts[0].card.expiryDate
    ${test_cardStatus}=                                     get value from json    ${response}                                  $.data.contract.cardContracts[0].card.status
    ${test_orderReference}=                                 get value from json    ${response}                                  $.data.contract.cardContracts[0].card.orders[0].orderIdentifier.orderReference
    ${accounts}                                             get value from json    ${response}                                  $.data.contract.accounts
    ${NumberOfAccounts}=                                    Get Length             @{accounts}
    ${x}=                                                   Set Variable           ${0}
    WHILE    ${x} < ${NumberOfAccounts}
        ${val}                                              get value from json    ${response}                                  $.data.contract.accounts[${x}].root
        IF    ${val[0]} == False
            ${test_child_accounts}                          get value from json    ${response}                                  $.data.contract.accounts[${x}].accountIdentifier.accountReference
            ${test_child_issuerAccountExternalReference}    get value from json    ${response}                                  $.data.contract.accounts[${x}].accountIdentifier.issuerAccountExternalReference
        ELSE
            ${test_root_accounts}                           get value from json    ${response}                                  $.data.contract.accounts[${x}].accountIdentifier.accountReference
            ${test_root_issuerAccountExternalReference}     get value from json    ${response}                                  $.data.contract.accounts[${x}].accountIdentifier.issuerAccountExternalReference
        END
        ${x}=                                               Evaluate               ${x} + 1
    END
    set to dictionary                                       ${cntr_res_data}       contractReference                            ${test_contractReference[0]}
    set to dictionary                                       ${cntr_res_data}       issuerContractExternalReference              ${test_issuerContractExternalReference[0]}
    set to dictionary                                       ${cntr_res_data}       cardContractReference                        ${test_cardContractReference[0]}
    set to dictionary                                       ${cntr_res_data}       issuerCardContractExternalReference          ${test_issuerCardContractExternalReference[0]}
    set to dictionary                                       ${cntr_res_data}       customerReference                            ${test_customerReference[0]}
    set to dictionary                                       ${cntr_res_data}       issuerCustomerExternalReference              ${test_issuerCustomerExternalReference[0]}
    set to dictionary                                       ${cntr_res_data}       firstName                                    ${test_firstName[0]}
    set to dictionary                                       ${cntr_res_data}       lastName                                     ${test_lastName[0]}
    set to dictionary                                       ${cntr_res_data}       cardReference                                ${test_cardReference[0]}
    set to dictionary                                       ${cntr_res_data}       issuerCardExternalReference                  ${test_issuerCardExternalReference[0]}
    set to dictionary                                       ${cntr_res_data}       pan                                          ${test_pan[0]}
    set to dictionary                                       ${cntr_res_data}       expiryDate                                   ${test_expiryDate[0]}
    set to dictionary                                       ${cntr_res_data}       cardStatus                                   ${test_cardStatus[0]}
    set to dictionary                                       ${cntr_res_data}       child_accountReference                       ${test_child_accounts[0]}
    set to dictionary                                       ${cntr_res_data}       child_issuerAccountExternalReference         ${test_child_issuerAccountExternalReference[0]}
    set to dictionary                                       ${cntr_res_data}       root_accountReference                        ${test_root_accounts[0]}
    set to dictionary                                       ${cntr_res_data}       root_issuerAccountExternalReference          ${test_root_issuerAccountExternalReference[0]}
    [Return]                                                ${cntr_res_data}


Contract Creation Request data
    [Documentation]   Basic Template to Create Contract create-consumer-contract.json
    Contract Creation Json Data Preparation     DE
    ${JSON_FILE}=    Load Json From File        ${CURDIR}/../../../../resources/ibo/restapi/templates/contract/create_consumer_contract.json
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].issuerCustomerExternalReference                                  CUS_EXT_REF_${unique_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].firstName                                                        ${first_name}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].birthDate                                                        ${cntr_dob}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].employerName                                                     ANNABATHINA ${first_name}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].secretAnswer                                                     ${color}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].partnerExternalReference                                         PAT_EXT_REF_${unique_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].addresses[0].postalAddress.line1                                 ${first_name} ANNABATHINA
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].addresses[0].postalAddress.buildingNumber                        ${building_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].addresses[0].postalAddress.boxNumber                             ${box_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].addresses[0].postalAddress.streetName                            ${street_name}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].addresses[0].emailAddress.email                                  ${first_name}.annabathina@wgs.com
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].addresses[0].addressUsages[0].entityReference                    ENT_REF_${unique_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].addresses[0].issuerAddressExternalReference                      ADD_EXT_REF_${unique_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.issuerProductExternalReference                                       ${product_config_templates.issuerProductExternalReference}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.cardReleaseOrder                                                     MANUAL
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.accountHierarchy.accounts[0].issuerAccountExternalReference          ROOT_ACC_EXT_REF_${unique_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.accountHierarchy.accounts[0].accountTemplateReference                ${product_config_templates.rootAccountTemplateReference}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.accountHierarchy.accounts[0].iban                                    ${iban1}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.accountHierarchy.accounts[0].secondIban                              ${iban2}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.accountHierarchy.accounts[1].issuerAccountExternalReference          CHILD_ACC_EXT_REF_${unique_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.accountHierarchy.accounts[1].accountTemplateReference                ${product_config_templates.accountTemplateReference}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.accountHierarchy.accounts[1].iban                                    ${iban3}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.accountHierarchy.accounts[1].secondIban                              ${iban4}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.cardContracts[0].card.issuerCardExternalReference                    CARD_EXT_REF_${unique_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.cardContracts[0].issuerCardContractExternalReference                 CARD_CNT_EXT_REF_${unique_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.cardContracts[0].cardTemplateReference                               ${product_config_templates.cardTemplateReference}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.contract.cardContracts[0].forcedEmbossingName                                 ${first_name} ANNABATHINA
    [Return]    ${JSON_FILE}

