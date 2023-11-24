*** Settings ***
Resource    ../resource/config.resource
Resource    ../requests/produtos.robot

#Test Setup       Start_Session_FakerApi

Documentation    The user do a register the product


*** Test Cases ***
Scenario: Register a product
    Given I make login
    When I register the product
    And I do a PUT to update product
    And I do a GET to confirm product
    Then I DELETE the created product
