*** Settings ***
Resource            ../../../../interface/ibo/restapi/contract/ContractCreationAPI.resource
Resource            ../../../../interface/ibo/restapi/card/CardLifeCycleAPI.resource
Resource            ../../../../interface/ibo/restapi/card/RetrieveCardAPI.resource


*** Keywords ***
API TC03 - Card lifecycle
    [Documentation]                             Card lifecycle
    ${cntr_res_data}                            Run IBO Contract Cration API
    set global variable                         ${cntr_res_data}            &{cntr_res_data}
    IF    '${cntr_res_data.cardStatus}' == 'CREATED'
        Run IBO Activate a card API
    END
    Run IBO Retrieve card API                   ${cntr_res_data.cardReference}      ACTIVE        1       ${cntr_res_data.issuerCardExternalReference}
    Run IBO Block a card API
    Run IBO Retrieve card API                   ${cntr_res_data.cardReference}      BLOCKED       1       ${cntr_res_data.issuerCardExternalReference}
    Run IBO UnBlock a card API
    Run IBO Retrieve card API                   ${cntr_res_data.cardReference}      ACTIVE        1       ${cntr_res_data.issuerCardExternalReference}
    Run IBO Deactivate a card API
    Run IBO Retrieve card API                   ${cntr_res_data.cardReference}      DEACTIVATED   1       ${cntr_res_data.issuerCardExternalReference}