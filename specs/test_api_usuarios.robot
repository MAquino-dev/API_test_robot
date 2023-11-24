*** Settings ***
Resource    ../resource/config.resource
Resource    ../requests/usuarios.robot
#Resource    ../requests/produtos.robot

#Test Setup       Start_Session_FakerApi

Documentation    The user do a resquest Get


*** Test Cases ***
Scenario: Register on the Test site
    Given I do a POST
    When I do a GET
    And I do a PUT to update user
    And I do a GET again
    Then I DELETE the created user