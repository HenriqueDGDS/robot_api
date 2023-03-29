*** Settings ***
Force Tags    @regression
Resource    ../base.robot
Resource    ./Keywords/UsuarioKW.robot
Resource    ../Commons/CommonKW.robot

*** Test Cases ***
Editando usuario com sucesso
    [Tags]    @Editar
    Criar Usuario
    Criar Dados Para Usuario Com O Faker
    Editar Usuário                ${USER.nome}    ${USER.email}    ${USER.password}
    Should Be Equal As Strings    ${response.json()['message']}    Registro alterado com sucesso

#Editando usuario sem sucesso
 #   [Tags]    @Editar
  #  Criar Usuario
   # Editar Usuário                ${USER.nome}    ${USER.email}    ${USER.password}
    #Should Be Equal As Strings    ${response.json()['message']}    Este email já está sendo usado