Feature: Sign Up new user

  Background: Preconditions
    Given url apiUrl
@debug
    Scenario: New user Sign Up
    karate.logger.debug('Running signup Test')
      Given path 'users'
      And request {"user": {"email": "tester05@test.com","password": "12345678","username": "tester05"}}
      When method post
      Then status 200
