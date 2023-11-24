*** Settings ***
Resource    ../resource/config.resource
Resource    ../data/post_cart_data.robot
Resource    ../data/put_data.robot
Resource    ../requests/usuarios.robot
Resource    ../data/login.robot
Resource    ../specs/test_api_carrinhos.robot

*** Keywords ***
I make login in server
    #I do a POST
    Start_session_serverest
    ${headers_login}      Create Dictionary      accept=application/json     Content-Type=application/json
    ${response_login}     POST On Session     serverest    url=/login       expected_status=200      headers=${headers_login}    data=${login_request}
    ${token}    Set Variable   ${response_login.json()['authorization']}
    Log To Console    ${token}
    Set Global Variable      ${token}   ${response_login.json()['authorization']}

I register the products
    Log     First product ID
    ${headers_product_one}    Create Dictionary      accept=application/json        Content-Type=application/json    Authorization=${token}
    ${response_product_one}     POST On Session     serverest    url=/produtos       expected_status=201      headers=${headers_product_one}    data=${product_one}
    Set Global Variable      ${generated_id_one}    ${response_product_one.json()['_id']}

    Log     Second product ID
    ${headers_product_two}    Create Dictionary      accept=application/json        Content-Type=application/json    Authorization=${token}
    ${response_product_two}     POST On Session     serverest    url=/produtos       expected_status=201      headers=${headers_product_two}    data=${product_two}
    Set Global Variable      ${generated_id_two}    ${response_product_two.json()['_id']}

I register cart
    Log     Registering the cart
    ${headers_cart}    Create Dictionary      accept=application/json        Content-Type=application/json    Authorization=${token}
    ${products}  Set Variable   {"produtos": [{"idProduto": "${generated_id_one}", "quantidade": 100}, {"idProduto": "${generated_id_two}", "quantidade": 100}]}
    ${response_cart}     POST On Session     serverest    url=/carrinhos       expected_status=201      headers=${headers_cart}    data=${products}
    Set Global Variable      ${generated_cart_id}    ${response_cart.json()['_id']}
    Set Global Variable      ${cart}    ${response_cart}
    ${message}   Set Variable     ${response_cart.json()['message']}
    Should Be Equal          ${message}    Cadastro realizado com sucesso

I do a GET confirm cart
    Log     Validating that the cart was created
    ${headers_get_cart}   Create Dictionary   accept=application/json     Authorization=${token}
    ${response_get_cart}  GET On Session    alias=serverest    url=/carrinhos/${generated_cart_id}   expected_status=200     headers=${headers_get_cart}  #data=${cart}
    Set Test Variable    ${response_get_cart}
    Should Be True    '${response_get_cart.status_code}'=='200'

I DELETE the created cart
    Log     Deleting cart
    ${headers_delete_cart}   Create Dictionary    Accept=application/json    Authorization=${token}
    ${response_delete_cart}    DELETE On Session    alias=serverest    url=/carrinhos/cancelar-compra   expected_status=200   headers=${headers_delete_cart}
    ${message_delete_cart}   Set Variable      ${response_delete_cart.json()['message']}
    Should Be Equal    ${message_delete_cart}    Registro excluído com sucesso. Estoque dos produtos reabastecido

    Log     Delete product one
    ${headers_delete_product_one}   Create Dictionary    Accept=application/json    Authorization=${token}
    ${response_delete_one}    DELETE On Session    alias=serverest    url=/produtos/${generated_id_one}   expected_status=200   headers=${headers_delete_product_one}
    ${message_delete_one}   Set Variable      ${response_delete_one.json()['message']}
    Should Be Equal    ${message_delete_one}    Registro excluído com sucesso

    Log     Delete product two
    ${headers_delete_product_two}   Create Dictionary    Accept=application/json    Authorization=${token}
    ${response_delete_two}    DELETE On Session    alias=serverest    url=/produtos/${generated_id_two}   expected_status=200   headers=${headers_delete_product_two}
    ${message_delete_two}   Set Variable      ${response_delete_two.json()['message']}
    Should Be Equal    ${message_delete_two}    Registro excluído com sucesso


