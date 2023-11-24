*** Settings ***
Resource    ../resource/config.resource
Resource    ../requests/carrinhos.robot

#Test Setup       Start_Session_FakerApi

Documentation    The user do a validate the cart


*** Test Cases ***
Scenario: Post a shopping cart
    Given I make login in server
    And I register the products
    When I register cart
    And I do a GET confirm cart
    And I DELETE the created cart