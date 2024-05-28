*** Settings ***
Library     RequestsLibrary
Library    Collections
Library    BuiltIn

*** Variables ***
${Base_URL}    http://localhost:8080

*** Test Cases ***
Get All Devices
    ${response}    GET    ${Base_URL}/devices
    ${status}    Convert To String    ${response.status_code}
    ${content}    Set Variable    ${response.json()}
    Log To Console    Status is: ${status}
    Log To Console    Content is: ${content}
    Should Be True    ${status}==200
    Should Be True    isinstance(${content}, list)
    Should Be True    ${content} is not None
    FOR    ${item}    IN    @{content}
        Log To Console    ${item}
        Should Be True    isinstance(${item}, dict)
        Dictionary Should Contain Key    ${item}    name
        Dictionary Should Contain Key    ${item}    ip
    END

