*** Settings ***
Resource    ../resource/config.resource
Resource    ../data/post_product_data.robot
Resource    ../requests/usuarios.robot
Resource    ../data/login.robot

*** Variables ***
${url}   https://serverest.dev

*** Keywords ***
I make login
   #I do a POST
    Start_session_serverest
    ${headers_login}      Create Dictionary      accept=application/json     Content-Type=application/json
    ${response_login}     POST On Session     serverest    url=/login       expected_status=200      headers=${headers_login}    data=${login_request}
    ${token}    Set Variable   ${response_login.json()['authorization']}
    Set Global Variable      ${token}   ${response_login.json()['authorization']}

I register the product
    ${headers_created_product}    Create Dictionary      accept=application/json        Content-Type=application/json    Authorization=${token}
    ${response_created_product}     POST On Session     serverest    url=/produtos       expected_status=201      headers=${headers_created_product}    data=${body_request_product}
    ${id}   Set Variable     ${response_created_product.json()['_id']}
    Set Global Variable      ${generated_id}    ${response_created_product.json()['_id']}

I do a PUT to update product
    ${headers_put}   Create Dictionary   Accept=application/json    Content-Type=application/json    Authorization=${token}
    ${response}  PUT On Session    alias=serverest   url=/produtos/${generated_id}   expected_status=200   headers=${headers_put}  data=${body_request_product_updated}
    ${message}   Set Variable      ${response.json()['message']}
    Should Be Equal    ${message}    Registro alterado com sucesso

I do a GET to confirm product
    ${headers_get}   Create Dictionary       Accept=application/json    Authorization=${token}
    ${response_get}  GET On Session    alias=serverest    url=/produtos/${generated_id}   expected_status=200   headers=${headers_get}
    ${updated_product_data}  Set Variable   ${response_get.json()}
    Should Be Equal As Strings   ${updated_product_data['nome']}   books
    Should Be Equal As Strings   ${updated_product_data['preco']}   20
    Should Be Equal As Strings   ${updated_product_data['descricao']}   learnning
    Should Be Equal As Strings   ${updated_product_data['quantidade']}   200

I DELETE the created product
    ${headers_delete}   Create Dictionary    Accept=application/json    Authorization=${token}
    ${response_delete}    DELETE On Session    alias=serverest    url=/produtos/${generated_id}   expected_status=200   headers=${headers_delete}
    ${message_delete}   Set Variable      ${response_delete.json()['message']}
    Should Be Equal    ${message_delete}    Registro excluído com sucesso