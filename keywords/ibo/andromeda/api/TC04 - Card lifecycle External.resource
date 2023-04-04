*** Settings ***
Resource            ../../../../interface/ibo/restapi/contract/ContractCreationAPI.resource
Resource            ../../../../interface/ibo/restapi/card/CardLifeCycleAPI.resource
Resource            ../../../../interface/ibo/restapi/card/RetrieveCardAPI.resource

*** Keywords ***
API TC04 - Card lifecycle External
    [Documentation]                         Card lifecycle
    ${cntr_res_data}                        Run IBO Contract Cration API
    set global variable                     ${cntr_res_data}            &{cntr_res_data}
    IF    '${cntr_res_data.cardStatus}' == 'CREATED'
        Run IBO Activate a card ext API
    END
    Run IBO Retrieve card ext API                   ${cntr_res_data.cardReference}      ACTIVE        1       ${cntr_res_data.issuerCardExternalReference}
    Run IBO Block a card ext API
    Run IBO Retrieve card ext API                   ${cntr_res_data.cardReference}      BLOCKED       1       ${cntr_res_data.issuerCardExternalReference}
    Run IBO UnBlock a card ext API
    Run IBO Retrieve card ext API                   ${cntr_res_data.cardReference}      ACTIVE        1       ${cntr_res_data.issuerCardExternalReference}
    Run IBO Deactivate a card ext API
    Run IBO Retrieve card ext API                   ${cntr_res_data.cardReference}      DEACTIVATED   1       ${cntr_res_data.issuerCardExternalReference}