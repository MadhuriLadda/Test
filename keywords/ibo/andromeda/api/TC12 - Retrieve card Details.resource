*** Settings ***
Resource            ../../../../interface/ibo/restapi/contract/ContractCreationAPI.resource
Resource            ../../../../interface/ibo/restapi/card/RetrieveCardAPI.resource

*** Keywords ***
API TC12 - Retrieve card Details
    [Documentation]                 Retrieve card Details
    ${cntr_res_data}                Run IBO Contract Cration API
    set global variable             ${cntr_res_data}                    &{cntr_res_data}
    Run IBO Retrieve card API       ${cntr_res_data.cardReference}      ${cntr_res_data.cardStatus}        1         ${cntr_res_data.issuerCardExternalReference}
    Run IBO Retrieve card ext API   ${cntr_res_data.cardReference}      ${cntr_res_data.cardStatus}        1         ${cntr_res_data.issuerCardExternalReference}