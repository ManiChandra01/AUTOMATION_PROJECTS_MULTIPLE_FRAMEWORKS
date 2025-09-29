*** Settings ***
Library   DataDriver   ../TestData/demo.xlsx   sheet_name=Sheet1
Test Template   Print data

*** Test Cases ***
FetchDataFromExcel using ${username} ${password}

*** Keywords ***
Print data
    [Arguments]  ${username}  ${password}
    Log To Console    ${username}
    Log To Console    ${password}