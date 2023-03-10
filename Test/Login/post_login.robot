*** Settings ***
Resource    ../base.robot
Resource    ./keywords/LoginKW.robot
Force Tags    @regression

*** Test Cases ***
Login com sucesso
    [Tags]    @Login
    Login    beltrano@qa.com.br    teste
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be Equal As Strings    ${response.json()['message']}    Login realizado com sucesso

Login sem sucesso
    [Tags]    @Login
    Login    emailinvalido@qa.com    aeugs
    Should Be Equal As Strings    ${response.status_code}    401
    Should Be Equal As Strings    ${response.json()['message']}    Email e/ou senha inválidos

Login com email invalido
    [Tags]    @Login
    Login    emailinvalido.qa.com    aeugs
    Should Be Equal As Strings    ${response.status_code}    400
    Should Be Equal As Strings    ${response.json()['email']}    email deve ser um email válido

Login com senha em branco
    [Tags]    @Login
    Login    email@qa.com    ${EMPTY}   
    Should Be Equal As Strings    ${response.status_code}    400
    Should Be Equal As Strings    ${response.json()['password']}    password não pode ficar em branco