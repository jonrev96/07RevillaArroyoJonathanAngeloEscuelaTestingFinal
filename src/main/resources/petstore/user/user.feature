Feature: User management

  Background:
    * url baseUrl

  @happy
  Scenario: Crear un usuario correctamente
    Given path '/user'
    And request
    """
    {
      "id": 12345,
      "username": "karateUser",
      "firstName": "Test",
      "lastName": "User",
      "email": "test@correo.com",
      "password": "123456",
      "phone": "999999999",
      "userStatus": 1
    }
    """
    When method post
    Then status 200
    And match response.message == '12345'

  @unhappy
  Scenario: Obtener usuario inexistente
    Given path '/user/usuarioQueNoExiste123'
    When method get
    Then status 404