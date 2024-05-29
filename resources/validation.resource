*** Keywords ***
Validate Device List
    [Arguments]    ${device_list}
    Should Be True    isinstance(${device_list}, list)
    Should Be True    ${device_list} is not None
    FOR    ${device}    IN    @{device_list}
        Log To Console    Device is: ${device}
        Validate Device Object    ${device}
    END

Validate Device Object
    [Arguments]    ${device_obj}
    Should Be True    isinstance(${device_obj}, dict)
    Dictionary Should Contain Key    ${device_obj}    name
    Dictionary Should Contain Key    ${device_obj}    ip
#    Validate Data Type    ${device_obj}    name    str
#    Validate Data Type    ${device_obj}    ip    str

#Validate Data Type
#    [Arguments]    ${dictionary}    ${key}    ${expected_type}
#    ${value}    Get From Dictionary    ${dictionary}    ${key}
#    ${is_expected_type}=    Evaluate    isinstance(${value}, ${expected_type})
#    Should Be True    ${is_expected_type}    The key '${key}' is not of type ${expected_type.__name__}

Validate Device Name
    [Arguments]    ${device_list}    ${expected_value}
    ${device_names}    Create List
    FOR    ${device}    IN    @{device_list}
        Append To List    ${device_names}    ${device}[name]
    END
    List Should Contain Value    ${device_names}    ${expected_value}

Check Succession Of API
    [Arguments]     ${json_value}
    Dictionary Should Contain Key    ${json_value}    success
    ${value}    Get From Dictionary    ${json_value}    success
    ${is_expected_type}=    Evaluate    isinstance(${value}, bool)
    Log To Console    Is expected type: ${is_expected_type}
    Should Be True    ${is_expected_type}==True