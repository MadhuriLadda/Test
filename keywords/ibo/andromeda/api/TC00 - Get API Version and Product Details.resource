*** Settings ***
Resource            ../../../../interface/ibo/restapi/common/GetProductDetails.resource

*** Variables ***
${BASE_API_URL}


*** Keywords ***
API TC00 - Get Api Version and Product Details
    log                                                 ${BASE_API_URL}
    Get IBO Retrieve API Metadata Information
    Get IBO IssuesID from Product
    Get IBO Product Details By Product Reference