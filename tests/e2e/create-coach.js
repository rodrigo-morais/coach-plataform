module.exports = {
  'List all coaches and mentors' : function (browser) {
    browser
      .url('http://192.168.99.100')
      .waitForElementVisible('button[id=searchButton]', 1000)
      .click('button[id=searchButton]')
      .pause(1000)
      .assert.containsText('#main', 'Kathryn Watson')
      .end();
  }
};