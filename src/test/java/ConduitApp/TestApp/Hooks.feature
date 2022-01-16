@debug
  Feature: Hooks

    Background: hooks
      * def result = call read('classpath:helpers/GetUserName.feature')
      #use callonce read ==> for caching same result entire test suite
      #karate.callSingle at karate.config to call before all features/Test run
      #karate.call at karate.config to call before every scenario
      * def username = result.username

    Scenario: First Scenario
      * print username
      * print "This is the first scenario"

    Scenario: First Scenario
      * print username
      * print "This is the second scenario"

            #after hooks
      * configure afterFeature = function() { karate.call('classpath:helpers/GetUserName.feature')}
      * configure afterScenario =
#      """
#        function(){
#        karate.log('After Feature Text');
#      """
      # * configure afterScenario ==> to run it after every Scenario
      # * configure afterFeature  ==> to run it after every Feature
