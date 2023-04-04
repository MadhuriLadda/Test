*** Settings ***
Library    Collections
Library    BuiltIn

*** Variables ***
@{andromeda_NN_List}                PDT_10004_MCD_DEBIT_PHYS        PDT_10004_MCD_DEBIT_VIRT        PDT_10004_MCD_CREDIT_PHYS       PDT_10004_MCD_CREDIT_VIRT       PDT_10004_DMC_DEBIT_PHYS        PDT_10004_DMC_DEBIT_VIRT
@{andromeda_ING_List}               PDT_6500_VISA_DEBIT_CLASSIC     PDT_6500_VISA_DEBIT_CLASSIC_SHARE
@{andromeda_CODI_List}              PDT_6601_VISA_DEBIT
@{andromeda_BNPP_List}              PDT_6900_DEBIT                  PDT_6900_GOLD                   PDT_6900_GOLDWM
@{andromeda_products_list}          PDT_10004_MCD_DEBIT_PHYS   PDT_10004_MCD_DEBIT_VIRT   PDT_10004_MCD_CREDIT_PHYS   PDT_10004_MCD_CREDIT_VIRT   PDT_10004_DMC_DEBIT_PHYS   PDT_10004_DMC_DEBIT_VIRT    PDT_6500_VISA_DEBIT_CLASSIC   PDT_6500_VISA_DEBIT_CLASSIC_SHARE    PDT_6900_DEBIT   PDT_6900_GOLD   PDT_6900_GOLDWM


*** Keywords ***
Add all issuers products into One List
    ${andromeda_products}      combine lists      ${andromeda_NN_List}    ${andromeda_NN_List}    ${andromeda_CODI_List}    ${andromeda_BNPP_List}
    [Return]                        ${andromeda_products}


