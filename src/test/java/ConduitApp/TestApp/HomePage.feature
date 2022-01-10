Feature: Tests for the home page

  Background: Define URL
    Given url apiUrl

  Scenario: Get all tags
    Given path "tags"
    When method get
    Then status 200
    And match response.tags contains ['welcome','codebaseShow']
    And match response.tags !contains "truck"
    #Check if response type is array
    And match response.tags == "#array"
    #Check if each tag at response type is string
    And match each response.tags == "#string"

  Scenario: Get 10 articles from page
    Given params { limit = 10, offset: 0}
    Given path "articles"
    When method get
    Then status 200
    #Checks if the article array size is 3
    And match response.articles == "#[10]"
    #Check if "articlesCount" field is equal to
    # 3 in response Message
    #And match response.articlesCount == 10

