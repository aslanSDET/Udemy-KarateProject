Feature: Tests for the home page

  Background: Define URL
    Given url apiUrl

  Scenario: Get all tags
    Given path "tags"
    When method get
    Then status 200
    And match response.tags contains ['welcome','codebaseShow']
    And match response.tags !contains "truck"
    And match response.tags contains any ['welcome', 'don't match', 'don't match02']
    #Check if response type is array
    And match response.tags == "#array"
    #Check if each tag at response type is string
    And match each response.tags == "#string"

  Scenario: Get 10 articles from page
    * def timeValidator = read('classpath:helpers/timeValidator.js')

    Given params { limit = 10, offset: 0}
    Given path "articles"
    When method get
    Then status 200
    #Verify multiple things in one response. Type verification and value verification
    And match response == { "articles": "#[10]", "articlesCount" :"#number"}
    #Schema Validation
    And match each response.articles ==
    """
        {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "tagList": "#array",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            },
            "favoritesCount": "#number",
            "favorited": "#boolean"
        }
    """

