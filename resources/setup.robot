*** Settings ***
Library     RequestsLibrary
Library    Collections
Library    BuiltIn
Resource    ./validation.robot

*** Variables ***
${Base_URL}    http://localhost:8080
${target_device_ip}     192.168.100.10

*** Keywords ***

Setup Connection Via Ip
    ${req_body}     Create Dictionary   ip=${target_device_ip}
    ${response}     POST    ${Base_URL}/connect     json=${req_body}
    Log To Console    Result from api is: ${response}
    Log To Console    Data from api is: ${response.content}
    ${status}       Convert To String    ${response.status_code}
    ${content}  Set Variable    ${response.json()}
    Check Succession Of API     ${content}      ${status}