
  Feature: Articles

    Background: Define URL
       Given url apiUrl

      Scenario: Create a new article
#        Given header Authorization = 'Token ' + myToken
        Given path "articles"
        And request {"article": {"tagList": [],"title": "Bla Bla55","description": "Bla test","body": "Bla test"}}
        When method post
        Then status 200
        And match response.article.title == "Bla Bla55"


    Scenario: Create and delete an article
      Given path "articles"
      And request {"article": {"tagList": [],"title": "DeleteMe6","description": "Better Delete It","body": "Delete this article please"}}
      When method post
      Then status 200
      * def articleId = response.article.slug

      Given params { limit = 10, offset: 0}
      Given path 'articles'
      When method get
      And match response.articles[0].title == "DeleteMe5"

      Given path 'articles',articleId
      When method delete
      Then assert responseStatus == 200 || responseStatus == 204

      Given params { limit = 10, offset: 0}
      Given path 'articles'
      When method get
      And match response.articles[0].title != "DeleteMe3"




