*** Settings ***
Resource            ../../../../interface/ibo/restapi/contract/ContractCreationAPI.resource
Resource            ../../../../interface/ibo/restapi/card/ReplaceCardAPI.resource
Resource            ../../../../interface/ibo/restapi/card/RetrieveCardAPI.resource


*** Keywords ***
API TC05-Replace card
    [Documentation]                         Relace card
    ${cntr_res_data}                        Run IBO Contract Cration API
    set global variable                     ${cntr_res_data}                    &{cntr_res_data}
    Run IBO Replace a card API
    Run IBO Retrieve card API               ${replaced_cardReference}           ${replaced_card_status}        2       ${replaced_issuerCardExternalReference}
    ${cntr_res_data}                        Run IBO Contract Cration API
    set global variable                     ${cntr_res_data}                    &{cntr_res_data}
    Run IBO Replace a card ext API
    Run IBO Retrieve card ext API           ${replaced_cardReference}           ${replaced_card_status}        2       ${replaced_issuerCardExternalReference}

