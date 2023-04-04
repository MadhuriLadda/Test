*** Settings ***
Resource            ../../../../interface/ibo/restapi/contract/ContractCreationAPI.resource
Resource            ../../../../interface/ibo/restapi/card/RetrieveCardByCardNumberAndSequenceNumberAndExpiryDateAPI.resource


*** Keywords ***
API TC11 - Retrieve card by cardNumber and sequenceNumber and expiryDate
    [Documentation]                                                                     Retrieve card by cardNumber and sequenceNumber and expiryDate
    ${cntr_res_data}                                                                    Run IBO Contract Cration API
    set global variable                                                                 ${cntr_res_data}                                                    &{cntr_res_data}
    Run IBO Retrieve card by cardNumber and sequenceNumber and expiryDate API           sequenceNumber
    Run IBO Retrieve card by cardNumber and sequenceNumber and expiryDate API           ALL
