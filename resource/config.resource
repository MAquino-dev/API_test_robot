*** Settings ***
Library  RequestsLibrary

*** Keywords ***

Start_session_serverest
   Create Session    alias=serverest    url=https://serverest.dev   verify=true