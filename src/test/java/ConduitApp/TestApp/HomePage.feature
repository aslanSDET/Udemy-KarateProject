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
  @parallel=false
    Scenario: Conditional logic
      Given params { limit = 10, offset: 0}
      Given path 'articles'
      When method get
      Then status 200
      * def favoritesCount = response.articles[0].favoritesCount
      * def article = response.articles[0]

      * if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)
      Given params { limit = 10, offset: 0}
      Given path 'articles'
      When method get
      Then status 200
      And match response.articles[0].favoritesCount == 1

  @parallel=false
  Scenario: Conditional logic with returning values
    Given params { limit = 10, offset: 0}
    Given path 'articles'
    When method get
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount
    * def article = response.articles[0]

    #If fav count is 0, then call the function to Addlikes. If FavCOunt is not 0,
    # then just take the value as result parameter as is
    * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likes : favoritesCount

    Given params { limit = 10, offset: 0}
    Given path 'articles'
    When method get
    Then status 200
    And match response.articles[0].favoritesCount == result

    @ignore
  Scenario: Retry call ==> Use this one
    * configure retry = { count: 10, interval: 1000 }

    Given params { limit: 10, offset: 0}
    Given path "articles"
    And retry until response.articles[0].favoritesCount == 1
    When method get
    Then status 200

  @ignore
  Scenario: Sleep call ==> Hardcoded sleep
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }
    Given params { limit: 10, offset: 0}
    Given path "articles"
    When method get
    * eval sleep(2000)
    Then status 200

  Scenario: Number to string
  * def foo = 10
  * def json = {"bar": #(foo+'')}
    #match to string: '10'
  * match json == {"bar": '10' }


  Scenario: String to Number
    * def foo = '10'
    #This option, multiply value by 1, makes the foo double NUMBER
    * def json = {"bar": #(foo*1)}
    # This option, parseInt will make the value double
    # Double tildas before ~~parseInt. This will make it integer NUMBER
    * def json2 = {"bar": #(~~parseInt(foo))}
    #match to number: 10
    * match json == {"bar": 10 }
    #match to String: '10'
      * match json == {"bar": 10 }
