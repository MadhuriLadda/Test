*** Settings ***
Library             REST    ssl_verify=false
Library             Collections
Library             String
Library             JSONLibrary
Library             BuiltIn
Resource            ../common/AuthenticationApi.resource
Resource            ../../../../libraries/RandomDataGeneration.resource

*** Variables ***
${BASE_BUSINESS_API_URL}
${productReference}
${issuerId}
${response_print_in_console}
${BASE_API_URL}
&{product_config_templates}

*** Keywords ***
Get IBO Product Details By Product Reference
    set basic Authentication
    [Documentation]     /issuers/{issuerId}/products/{productReference}
    REST.GET                                            ${BASE_BUSINESS_API_URL}/issuers/${issuerId}/products/${productReference}
    ${response}                                         REST.Output                                     response body                               also_console=False
    # ******** Verification *******
    Integer                                             response status                                 200
    ${get_productExternalReference}                     get value from json                             ${response}                                 $.data.productIdentifier.issuerProductExternalReference
    ${get_cardTemplateReference}                        get value from json                             ${response}                                 $.data.cardProducts[0].cardProductIdentifier.cardTemplateReference
    ${x}=                                               Set Variable                                    ${0}
    #While    ${x} < 2
    #FOR    ${i}    IN RANGE    2
        #Exit For Loop If    ${i} == 2
        ${val}                                          get value from json                             ${response}                                 $.data.accountProducts[${x}].accountProductIdentifier.accountTemplateReference
        ${is_root_ref}                                  Check Is Root Account tempate references        ${val[0]}
        IF    '${is_root_ref}' == 'False'
            ${get_child_accountTemplateRef}             get value from json                             ${response}                                 $.data.accountProducts[${x}].accountProductIdentifier.accountTemplateReference
        ELSE IF   '${is_root_ref}' == 'True'
            ${get_root_accountTemplateRef}              get value from json                             ${response}                                 $.data.accountProducts[${x}].accountProductIdentifier.accountTemplateReference
        END
        ${x}=                                               Set Variable                                    ${1}
        ${val}                                          get value from json                             ${response}                                 $.data.accountProducts[${x}].accountProductIdentifier.accountTemplateReference
        ${is_root_ref}                                  Check Is Root Account tempate references        ${val[0]}
        IF    '${is_root_ref}' == 'False'
            ${get_child_accountTemplateRef}             get value from json                             ${response}                                 $.data.accountProducts[${x}].accountProductIdentifier.accountTemplateReference
        ELSE IF   '${is_root_ref}' == 'True'
            ${get_root_accountTemplateRef}              get value from json                             ${response}                                 $.data.accountProducts[${x}].accountProductIdentifier.accountTemplateReference
        END
   #     ${x}=                                           Evaluate                                        ${x} + 1
    #END
    # ******** Get Product Extension Details **********
    ${get_productExtensionReference}                    get value from json                             ${response}                                 $.data.productExtensions[0].productExtensionIdentifier.productExtensionReference
    ${get_productExtensionExternalReference}            get value from json                             ${response}                                 $.data.productExtensions[0].externalReference
    ${get_product_Ext_accountTemplateReference}         get value from json                             ${response}                                 $.data.productExtensions[0].accountProducts[0].accountProductIdentifier.accountTemplateReference
    IF    ${get_productExtensionExternalReference} == []
          log                                           "productExtensionExternalReference same as productExtensionReference"
          set test variable                             ${productExtensionReference}                    ${productReference}
          set test variable                             ${productExtensionExternalReference}            ${get_productExternalReference}
          set test variable                             ${productExtensionChildAccountTemplateRef}      ${get_child_accountTemplateRef}
    ELSE
          set test variable                             ${productExtensionReference}                    ${get_productExtensionReference}
          set test variable                             ${productExtensionExternalReference}            ${get_productExtensionExternalReference}
          set test variable                             ${productExtensionChildAccountTemplateRef}      ${get_product_Ext_accountTemplateReference}
    END
    set to dictionary                                   ${product_config_templates}                     issuerProductExternalReference                      ${get_productExternalReference[0]}
    set to dictionary                                   ${product_config_templates}                     cardTemplateReference                               ${get_cardTemplateReference[0]}
    set to dictionary                                   ${product_config_templates}                     rootAccountTemplateReference                        ${get_root_accountTemplateRef[0]}
    set to dictionary                                   ${product_config_templates}                     accountTemplateReference                            ${get_child_accountTemplateRef[0]}
    set to dictionary                                   ${product_config_templates}                     productExtensionChildAccountTemplateReference       ${productExtensionChildAccountTemplateRef[0]}
    set to dictionary                                   ${product_config_templates}                     productExtensionExternalReference                   ${productExtensionExternalReference[0]}
    log variables




Get IBO Retrieve API Metadata Information
    set basic Authentication
    [Documentation]     /info
    REST.GET                        ${BASE_API_URL}/info
    ${response}                     REST.Output                                                 response body                                also_console=False
    # ******** Verification *******
    Integer                         response status                                             200
    ${version}=                     get value from json                                         ${response}                                  $.data.version
    set global variable             ${IBO_API_VERSION}                                          ${version[0]}
    log                             "your runing Jobs with API version ==> ${IBO_API_VERSION}"


Get IBO IssuesID from Product
    ${break_list}=                  Split String        ${productReference}             _
    ${issuerId_from_Product}=       Get From List       ${break_list}                   1
    set global variable             ${issuerId}         ${issuerId_from_Product}


