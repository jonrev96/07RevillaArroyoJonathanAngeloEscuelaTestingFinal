Feature: Store orders (Petstore)

  Background:
    * url baseUrl
    * def rand = java.util.UUID.randomUUID() + ''
    * def orderId = Math.abs(rand.hashCode())
    * def petId = 10

  @store @happy
  Scenario: Crear una orden
    Given path '/store/order'
    And request
    """
    {
      "id": #(orderId),
      "petId": #(petId),
      "quantity": 1,
      "shipDate": "2025-01-01T10:00:00.000Z",
      "status": "placed",
      "complete": true
    }
    """
    When method post
    Then status 200
    And match response.id == orderId
    And match response.petId == petId
    And match response.status == 'placed'
    And match response.complete == true

  @store @happy
  Scenario: Obtener orden creada
    # Creamos orden primero
    Given path '/store/order'
    And request
    """
    {
      "id": #(orderId),
      "petId": #(petId),
      "quantity": 2,
      "shipDate": "2025-01-01T10:00:00.000Z",
      "status": "placed",
      "complete": true
    }
    """
    When method post
    Then status 200

    Given path '/store/order', orderId
    When method get
    Then status 200
    And match response.id == orderId
    And match response.quantity == 2

  @store @happy
  Scenario: Eliminar orden creada
    # Creamos orden primero
    Given path '/store/order'
    And request
    """
    {
      "id": #(orderId),
      "petId": #(petId),
      "quantity": 1,
      "shipDate": "2025-01-01T10:00:00.000Z",
      "status": "placed",
      "complete": true
    }
    """
    When method post
    Then status 200

    Given path '/store/order', orderId
    When method delete
    Then status 200

  @store @unhappy
  Scenario: Buscar orden inexistente (404)
    Given path '/store/order', (orderId + 99999999)
    When method get
    Then status 404

  @store @unhappy
  Scenario: Buscar orden con id inválido (string) (404)
    Given path '/store/order/abc_no_valido'
    When method get
    Then status 404

  @store @happy
  Scenario: Consultar inventario
    Given path '/store/inventory'
    When method get
    Then status 200
    And match response == '#object'