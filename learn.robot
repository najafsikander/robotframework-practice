*** Settings ***
Library     RequestsLibrary
Library    Collections
Library    BuiltIn
Resource    ./resources/validation.robot
Resource    ./resources/setup.robot

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
     Setup Connection Via Ip
     Log To Console    Connection is established

Check State of Connected Device
    [Setup]     Setup Connection Via Ip
    Log To Console    Connection is establish
    ${response}     GET     ${Base_URL}/state
    ${status}       Convert To String    ${response.status_code}
    ${content}      Set Variable    ${response.json()}
    Should Be True    ${status}==200
    Log To Console    Status Code is: ${status}
    Log To Console    Content is: ${content}
    Valide Check State API Response     ${content}

Set Brightness of Connected Device
    [Setup]     Setup Connection Via Ip
    Log To Console    Connection is established for test 4
    ${req_body}      Create Dictionary      brightness=5
    ${response}      POST     ${Base_URL}/brightness     data=${req_body}
    Log To Console    Data from server: ${response}
    ${status}       Convert To String    ${response.status_code}
    ${content}      Set Variable    ${response.json()}
    Should Be True    ${status}==200
    Log To Console    Content is: ${content}
    Dictionary Should Contain Key    ${content}    success
    Log To Console    Success value: ${content}[success]
    Should Be True    ${content}[success]==True
