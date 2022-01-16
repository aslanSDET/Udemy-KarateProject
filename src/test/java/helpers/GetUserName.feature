Feature: GetUserName

  Scenario: GetUserName method

  * def dataGenerator = Java.type('helpers.DataGenerator')
  * def username = dataGenerator.getRandomUsername()
