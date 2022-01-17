
  Feature: Add likes

    Background:
  Feature: Add likes

    Background:
      * url apiUrl

    Scenario: add likes
      Given path 'articles', slug, 'favorite'
      And request {}
      When method POST
      Then status 200
      * def likesCount = response.article.favoritesCount
