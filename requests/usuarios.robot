*** Settings ***
Resource    ../resource/config.resource
Resource    ../data/post_data.robot
Resource    ../data/put_data.robot

*** Keywords ***
I do a POST
    Start_session_serverest
    ${headers}   Create Dictionary   Accept=application/json    Content-Type=application/json
    ${response}  POST On Session    alias=serverest     url=/usuarios   expected_status=201     headers=${headers}  data=${body_request}
    ${message}   Set Variable   ${response.json()['message']}
    Log To Console    ${response.json()}
    Should Be Equal    ${message}    Cadastro realizado com sucesso
    Set Global Variable     ${generated_id}      ${response.json()['_id']}

I do a GET
    Start_Session_ServerEst
    ${response}  GET On Session    alias=serverest    url=/usuarios/${generated_id}   expected_status=200
    ${user_data}  Set Variable   ${response.json()}
    Should Be Equal As Strings   ${user_data['_id']}   ${generated_id}

I do a PUT to update user
    Start_Session_ServerEst
    ${headers}   Create Dictionary   Accept=application/json    Content-Type=application/json
    ${response}  PUT On Session    alias=serverest     url=/usuarios/${generated_id}   expected_status=200     headers=${headers}  data=${body_request_updated}
    ${message}   Set Variable      ${response.json()['message']}
    Should Be Equal    ${message}    Registro alterado com sucesso

I do a GET again
    Start_Session_ServerEst
    ${response}  GET On Session    alias=serverest    url=/usuarios/${generated_id}   expected_status=200
    ${updated_user_data}  Set Variable   ${response.json()}
    Should Be Equal As Strings   ${updated_user_data['nome']}   Matias Sanchez

I DELETE the created user
    Start_Session_ServerEst
    ${response}    DELETE On Session    alias=serverest    url=/usuarios/${generated_id}   expected_status=200
    ${message}   Set Variable      ${response.json()['message']}
    Should Be Equal    ${message}    Registro excluído com sucesso