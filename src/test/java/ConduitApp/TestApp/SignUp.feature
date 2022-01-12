Feature: Sign Up new user

  Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUserName = dataGenerator.getRandomUsername()
    Given url apiUrl

    Scenario: New user Sign Up
    #karate.logger.debug('Running signup Test')


      # Call a non-static Java class/method
      # We need JS for karate
      # def jsFunction =
      # """
      #     function() {
      #       var DataGenerator = Java.type('helpers.DataGenerator')
      #       var generator = new DataGenerator()
      #       return generator.methodName()
      #     }
      # """
      Given path 'users'
      And request
      """
      {
          "user": {
              "email": #(randomEmail),
              "password": "12345678",
              "username": #(randomUserName)
          }
      }
      """

      When method post
      Then status 200
      And match response ==
      """
      {
          "user": {
              "email": #(randomEmail),
              "username": #(randomUserName),
              "bio": "##string",
              "image": "#string",
              "token": "#string"
          }
      }
      """

  Scenario Outline: Validate Sign Up error message
    Given path 'users'
    And request
    """
    {
      "user": {
          "email": "<email>",
          "password": "<password>",
          "username": "<username>"
      }
    }
    """
    When method post
    Then status 422
    And match response == <errrorResponse>

  Examples:
    | email             | password | username          | errrorResponse                                     |  |
    | #(randomEmail)    | 12345678 | tester02          | {"errors":{"username":["has already been taken"]}} |  |
    | tester02@test.com | 12345678 | #(randomUserName) | {"errors":{"email":["has already been taken"]}}    |  |
    | #(randomEmail)    |          | #(randomUserName) | {"errors":{"password":["can't be blank"]}}         |  |
    | #(randomEmail)    | 12345678 |                   | {"errors":{"username":["can't be blank"]}}         |  |
    |                   | 12345678 | #(randomUserName) | {"errors":{"email":["can't be blank"]}}            |  |



