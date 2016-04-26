module.exports = {
<<<<<<< 33a9ce2f48a586e158ab175fc3778fa35acb4704
  'List all coaches and mentors' : function (browser) {
    browser
      .url('http://192.168.99.100')
      .waitForElementVisible('button[id=searchButton]', 1000)
      .click('button[id=searchButton]')
      .pause(1000)
      .assert.containsText('#main', 'Kathryn Watson')
=======
  'Looking for Thoughtworks on Google' : function (browser) {
    browser
      .url('http://www.google.com')
      .waitForElementVisible('body', 1000)
      .setValue('input[type=text]', 'thoughtworks')
      .waitForElementVisible('button[name=btnG]', 1000)
      .click('button[name=btnG]')
      .pause(1000)
      .assert.containsText('#main', 'https://www.thoughtworks.com')
>>>>>>> Configuring the e2e test.
      .end();
  }
};