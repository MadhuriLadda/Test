*** Settings ***
Documentation       List accounts for contract API
Library             REST    ssl_verify=false
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

*** Keywords ***
Run Add cards and accounts to a contract API
    [Documentation]                                         /issuers/{issuerId}/contracts/{contractReference}/add-cards-accounts
    set basic Authentication
    ${JSON_FILE}=                                           Add Account and Contract To Contract Json Request data
    REST.POST
    ...   ${BASE_API_URL}/issuers/${issuerId}/contracts/${cntr_res_data.contractReference}/add-cards-accounts                       body=${JSON_FILE}
    REST.Output                                             response body                                                           also_console=False
    # ******** Verification *******
    Integer                                                 response status                                                         200
    ${response}                                             REST.Output                                                             response body                                                                           also_console=False
    ${accounts}                                             get value from json    ${response}                                      $.data.contract.accounts
    ${NumberOfAccounts}=                                    Get Length             @{accounts}
    ${x}=                                                   Set Variable           ${0}
    WHILE    ${x} < ${NumberOfAccounts}
        ${val}                                              get value from json    ${response}                                      $.data.contract.accounts[${x}].accountIdentifier.issuerAccountExternalReference
        IF    '${val[0]}' == 'ACC_EXT_REF_SUB_${unique_number}'
            ${add_ext_child_accounts}                       get value from json    ${response}                                      $.data.contract.accounts[${x}].accountIdentifier.accountReference
            ${add_ext_child_iss_AccountExternalReference}   get value from json    ${response}                                      $.data.contract.accounts[${x}].accountIdentifier.issuerAccountExternalReference
        END
        ${x}=                                               Evaluate               ${x} + 1
    END
    set to dictionary                                       ${cntr_res_data}       add_ext_child_accountReference                   ${add_ext_child_accounts[0]}
    set to dictionary                                       ${cntr_res_data}       add_ext_child_issuerAccountExternalReference     ${add_ext_child_iss_AccountExternalReference[0]}
    ${cardContracts}                                        get value from json    ${response}                                      $.data.contract.cardContracts
    ${NumberOfcardContracts}=                               Get Length             @{cardContracts}
    ${x}=                                                   Set Variable           ${0}
    WHILE    ${x} < ${NumberOfcardContracts}
        ${val}                                              get value from json    ${response}                                      $.data.contract.cardContracts[${x}].card.pan
        IF    '${val[0]}' != '${cntr_res_data.pan}'
            ${add_ext_child_pan}                            get value from json    ${response}                                      $.data.contract.cardContracts[${x}].card.pan
        END
        ${x}=                                               Evaluate               ${x} + 1
    END
    set to dictionary                                       ${cntr_res_data}       add_ext_child_pan                                ${add_ext_child_pan[0]}
    String
    ...     $.data.contract.accounts[0].accountIdentifier.accountReference
    ...     ${cntr_res_data.root_accountReference}
    ...     ${cntr_res_data.child_accountReference}
    ...     ${cntr_res_data.add_ext_child_accountReference}
    String
    ...     $.data.contract.accounts[1].accountIdentifier.issuerAccountExternalReference
    ...     ${cntr_res_data.root_issuerAccountExternalReference}
    ...     ${cntr_res_data.child_issuerAccountExternalReference}
    ...     ${cntr_res_data.add_ext_child_issuerAccountExternalReference}
    String
    ...     $.data.contract.accounts[2].accountIdentifier.issuerAccountExternalReference
    ...     ${cntr_res_data.root_issuerAccountExternalReference}
    ...     ${cntr_res_data.child_issuerAccountExternalReference}
    ...     ${cntr_res_data.add_ext_child_issuerAccountExternalReference}


Run Add cards and accounts to a contract ext API
    [Documentation]                                         /issuers/{issuerId}/contracts/external-contracts/{issuerContractExternalReference}/add-cards-accounts
    set basic Authentication
    ${JSON_FILE}=                                           Add Account and Contract To Contract Json Request data
    REST.POST
    ...   ${BASE_API_URL}/issuers/${issuerId}/contracts/external-contracts/${cntr_res_data.issuerContractExternalReference}/add-cards-accounts
    ...   body=${JSON_FILE}
    REST.Output                                             response body                                                           also_console=False
    # ******** Verification *******
    Integer                                                 response status                                                         200
    ${response}                                             REST.Output                                                             response body                                                                           also_console=False
    ${accounts}                                             get value from json    ${response}                                      $.data.contract.accounts
    ${NumberOfAccounts}=                                    Get Length             @{accounts}
    ${x}=                                                   Set Variable           ${0}
    WHILE    ${x} < ${NumberOfAccounts}
        ${val}                                              get value from json    ${response}                                      $.data.contract.accounts[${x}].accountIdentifier.issuerAccountExternalReference
        IF    '${val[0]}' == 'ACC_EXT_REF_SUB_${unique_number}'
            ${add_ext_child_accounts}                       get value from json    ${response}                                      $.data.contract.accounts[${x}].accountIdentifier.accountReference
            ${add_ext_child_iss_AccountExternalReference}   get value from json    ${response}                                      $.data.contract.accounts[${x}].accountIdentifier.issuerAccountExternalReference
        END
        ${x}=                                               Evaluate               ${x} + 1
    END
    set to dictionary                                       ${cntr_res_data}       add_ext_child_accountReference                   ${add_ext_child_accounts[0]}
    set to dictionary                                       ${cntr_res_data}       add_ext_child_issuerAccountExternalReference     ${add_ext_child_iss_AccountExternalReference[0]}
    ${cardContracts}                                        get value from json    ${response}                                      $.data.contract.cardContracts
    ${NumberOfcardContracts}=                               Get Length             @{cardContracts}
    ${x}=                                                   Set Variable           ${0}
    WHILE    ${x} < ${NumberOfcardContracts}
        ${val}                                              get value from json    ${response}                                      $.data.contract.cardContracts[${x}].card.pan
        IF    '${val[0]}' != '${cntr_res_data.pan}'
            ${add_ext_child_pan}                            get value from json    ${response}                                      $.data.contract.cardContracts[${x}].card.pan
        END
        ${x}=                                               Evaluate               ${x} + 1
    END
    set to dictionary                                       ${cntr_res_data}       add_ext_child_pan                                ${add_ext_child_pan[0]}
    String
    ...     $.data.contract.accounts[0].accountIdentifier.accountReference
    ...     ${cntr_res_data.root_accountReference}
    ...     ${cntr_res_data.child_accountReference}
    ...     ${cntr_res_data.add_ext_child_accountReference}
    String
    ...     $.data.contract.accounts[1].accountIdentifier.issuerAccountExternalReference
    ...     ${cntr_res_data.root_issuerAccountExternalReference}
    ...     ${cntr_res_data.child_issuerAccountExternalReference}
    ...     ${cntr_res_data.add_ext_child_issuerAccountExternalReference}
    String
    ...     $.data.contract.accounts[2].accountIdentifier.issuerAccountExternalReference
    ...     ${cntr_res_data.root_issuerAccountExternalReference}
    ...     ${cntr_res_data.child_issuerAccountExternalReference}
    ...     ${cntr_res_data.add_ext_child_issuerAccountExternalReference}



Add Account and Contract To Contract Json Request data
    [Documentation]   Basic Template to Create Add sub Account Contract to Parent Contract
    Add Account and Contract To Contract json Data Preparation     DE
    ${JSON_FILE}=    Load Json From File
    ...              ${CURDIR}/../../../../resources/ibo/restapi/templates/contract/Add_cards_and_accounts_to_a_contract.json
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].firstName                                                        ${first_name}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].birthDate                                                        ${cntr_dob}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].issuerCustomerExternalReference                                  CUS_EXT_REF_SUB_${unique_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].addresses[0].issuerAddressExternalReference                      ADD_EXT_REF_SUB_${unique_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].addresses[0].postalAddress.line1                                 ${first_name} ANNABATHINA
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].addresses[0].postalAddress.buildingNumber                        ${building_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].addresses[0].postalAddress.boxNumber                             ${box_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.customers[0].addresses[0].postalAddress.streetName                            ${street_name}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.issuerProductExtensionExternalReference                                       ${product_config_templates.productExtensionExternalReference}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.accountHierarchy.accounts[0].accountTemplateReference                         ${product_config_templates.accountTemplateReference}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.accountHierarchy.accounts[0].issuerAccountExternalReference                   ACC_EXT_REF_SUB_${unique_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.accountHierarchy.accounts[0].iban                                             ${iban5}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.accountHierarchy.accounts[0].secondIban                                       ${iban6}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.cardContracts[0].cardTemplateReference                                        ${product_config_templates.cardTemplateReference}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.cardContracts[0].forcedEmbossingName                                          ${first_name} ANNABATHINA
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.cardContracts[0].issuerCardContractExternalReference                          CARD_CNT_EXT_REF_${unique_number}
    ${JSON_FILE}=    update value to json       ${JSON_FILE}    $.cardContracts[0].card.issuerCardExternalReference                             CARD_EXT_REF_SUB_${unique_number}
    [Return]    ${JSON_FILE}