Feature: User management (Petstore)

  Background:
    * url baseUrl
    * def rand = java.util.UUID.randomUUID() + ''
    * def username = 'karateUser_' + rand
    * def userId = Math.abs(rand.hashCode())
    * def password = '123456'
    * def email = 'test_' + rand + '@correo.com'

  @user @happy
  Scenario: Crear un usuario correctamente
    Given path '/user'
    And request
    """
    {
      "id": #(userId),
      "username": "#(username)",
      "firstName": "Test",
      "lastName": "User",
      "email": "#(email)",
      "password": "#(password)",
      "phone": "999999999",
      "userStatus": 1
    }
    """
    When method post
    Then status 200
    And match response.code == 200
    And match response.message == userId + ''

  @user @happy
  Scenario: Obtener usuario creado
    # Creamos usuario primero (para que este escenario sea independiente)
    Given path '/user'
    And request
    """
    {
      "id": #(userId),
      "username": "#(username)",
      "firstName": "Test",
      "lastName": "User",
      "email": "#(email)",
      "password": "#(password)",
      "phone": "999999999",
      "userStatus": 1
    }
    """
    When method post
    Then status 200

    Given path '/user', username
    When method get
    Then status 200
    And match response.username == username
    And match response.email == email

  @user @happy
  Scenario: Login exitoso
    # Creamos usuario primero
    Given path '/user'
    And request
    """
    {
      "id": #(userId),
      "username": "#(username)",
      "firstName": "Test",
      "lastName": "User",
      "email": "#(email)",
      "password": "#(password)",
      "phone": "999999999",
      "userStatus": 1
    }
    """
    When method post
    Then status 200

    Given path '/user/login'
    And param username = username
    And param password = password
    When method get
    Then status 200
    And match response.code == 200

  @user @happy
  Scenario: Actualizar usuario (PUT)
    # Creamos usuario primero
    Given path '/user'
    And request
    """
    {
      "id": #(userId),
      "username": "#(username)",
      "firstName": "Test",
      "lastName": "User",
      "email": "#(email)",
      "password": "#(password)",
      "phone": "999999999",
      "userStatus": 1
    }
    """
    When method post
    Then status 200

    * def newEmail = 'updated_' + rand + '@correo.com'

    Given path '/user', username
    And request
    """
    {
      "id": #(userId),
      "username": "#(username)",
      "firstName": "Test",
      "lastName": "User",
      "email": "#(newEmail)",
      "password": "#(password)",
      "phone": "111111111",
      "userStatus": 1
    }
    """
    When method put
    Then status 200
    And match response.code == 200

    Given path '/user', username
    When method get
    Then status 200
    And match response.email == newEmail

  @user @happy
  Scenario: Eliminar usuario
    # Creamos usuario primero
    Given path '/user'
    And request
    """
    {
      "id": #(userId),
      "username": "#(username)",
      "firstName": "Test",
      "lastName": "User",
      "email": "#(email)",
      "password": "#(password)",
      "phone": "999999999",
      "userStatus": 1
    }
    """
    When method post
    Then status 200

    Given path '/user', username
    When method delete
    Then status 200
    And match response.code == 200

  @user @unhappy
  Scenario: Obtener usuario inexistente (404)
    Given path '/user/usuarioQueNoExiste_' + rand
    When method get
    Then status 404