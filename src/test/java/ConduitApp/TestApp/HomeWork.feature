@ignore
Feature: Home Work

  Background: Preconditions
    * url apiUrl
    * def articleFavIncreaseRequestBody = read('classpath:ConduitApp/json/articleFavIncreaseRequest.json')
    * def timeValidator = read('classpath:helpers/timeValidator.js')
  @debug
  Scenario: Favorite articles
        # Step 1: Get atricles of the global feed

    Given path 'articles'
    When method get
        # Step 2: Get the favorites count and slug ID for the first artice, save it to variables
    Then status 200
    * def articleId = response.articles[0].slug
    * def articleTitle = response.articles[0].title
    * def favoritesCount = parseInt(response.articles[0].favoritesCount)
    * print "======================= " + favoritesCount
        # Step 3: Make POST request to increse favorites count for the first article

    Given path 'articles' + '/' + articleId + '/favorite'
    And request {}
    When method POST
        # Step 2: Get the favorites count and slug ID for the first artice, save it to variables
    Then status 200
        # Step 4: Verify response schema
    And match response ==
  """
  {
    "article": {
        "id": "#number",
        "slug": #(articleId),
        "title": #(articleTitle),
        "description": "#string",
        "body": "#string",
        "tagList": "#array",
        "createdAt": "#? timeValidator(_)",
        "updatedAt": "#? timeValidator(_)",
        "authorId": "#number",
        "author": {
            "username": "#string",
            "bio": null,
            "image": "#string",
            "following": "#boolean",
        },
        "favoritedBy": [
            {
                "id": "#number",
                "email": "#string",
                "username": "#string",
                "password": "#string",
                "image": "#string",
                "bio": null,
                "demo": "#boolean",
            }
        ],
        "favorited": "#boolean",
        "favoritesCount": "#number",
    }
}
  """

        # Step 5: Verify that favorites article incremented by 1
            #Example
    * def initialCount = 0
    * def response = {"favoritesCount": 1}
#            * match response.favoritesCount == initialCount + 1

        # Step 6: Get all favorite articles
    Given path 'articles'
  #  favorited : true seems to be broken, hence looking for articles with only 1 likes
    Given params {"favorited":true}
    When method get
    Then status 200
        # Step 7: Verify response schema
        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
  #  contains deep checks if our articleId is present in any result. Ignore schema
    #And match response.articles contains deep {slug: '#(articleId)'}
