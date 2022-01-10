function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit.productionready.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = "karate99@test.com"
    config.userPassword = "12345678"
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'QA') {
    config.userEmail = "karateQA@test.com"
    config.userPassword = "QA12345678"
    // customize
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature',config).authToken
  karate.configure('headers',{Authorization: 'Token ' + accessToken})
  return config;
}
