Feature: Store orders

  Background:
    * url baseUrl

  @happy
  Scenario: Crear una orden
    Given path '/store/order'
    And request
    """
    {
      "id": 1,
      "petId": 10,
      "quantity": 1,
      "shipDate": "2025-01-01T10:00:00.000Z",
      "status": "placed",
      "complete": true
    }
    """
    When method post
    Then status 200
    And match response.id == 1
    And match response.petId == 10
    And match response.quantity == 1
    And match response.status == 'placed'
    And match response.complete == true

  @unhappy
  Scenario: Buscar orden inexistente
    Given path '/store/order/999999999'
    When method get
    Then status 404