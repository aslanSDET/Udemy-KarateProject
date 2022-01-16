@parallel=false
  Feature: Articles

    Background: Define URL
       * url apiUrl
       * def articleRequestBody = read('classpath:ConduitApp/json/newArticleRequest.json')
       * def dataGenerator = Java.type('helpers.DataGenerator')
       * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
       * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
       * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

    Scenario: Create and delete an article
      Given path "articles"
      And request articleRequestBody
      When method post
      Then status 200
      * def articleId = response.article.slug

      Given params { limit = 10, offset: 0}
      Given path 'articles'
      When method get
      Then status 200
      And match response.articles[0].title == articleRequestBody.article.title

      Given path 'articles',articleId
      When method delete
      Then assert responseStatus == 200 || responseStatus == 204

      Given params { limit = 10, offset: 0}
      Given path 'articles'
      When method get
      And match response.articles[0].title != articleRequestBody.article.title

    Scenario: Create a new article
#        ReadMe Given header Authorization = 'Token ' + myToken
        Given path "articles"
        And request articleRequestBody
        When method post
        Then status 200
        And match response.article.title == articleRequestBody.article.title







