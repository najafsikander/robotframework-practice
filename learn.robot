*** Settings ***
Library     RequestsLibrary
Library    Collections
Library    BuiltIn
Resource    ./resources/validation.resource

*** Variables ***
${Base_URL}    http://localhost:8080
${target_device_ip}     192.168.100.10

*** Test Cases ***
Get All Devices
    ${response}    GET    ${Base_URL}/devices
    ${status}    Convert To String    ${response.status_code}
    ${content}    Set Variable    ${response.json()}
    Log To Console    Status is: ${status}
    Log To Console    Content is: ${content}
    Should Be True    ${status}==200
    Validate Device List    ${content}
    Validate Device Name    ${content}    bulb1
    Validate Device Name    ${content}    bulb2

Connect To A Device
    ${req_body}     Create Dictionary   ip=${target_device_ip}
    ${response}     POST    ${Base_URL}/connect     json=${req_body}
    Log To Console    Result from api is: ${response}
    Log To Console    Data from api is: ${response.content}
    ${content}  Set Variable    ${response.json()}
    Check Succession Of API     ${content}