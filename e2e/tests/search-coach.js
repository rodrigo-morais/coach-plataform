module.exports = {
  'List all coaches and mentors' : function (browser) {
    browser
      .url('http://localhost:5000')
      .waitForElementVisible('button[id=searchButton]', 1000)
      .click('button[id=searchButton]')
      .pause(1000)
      .assert.containsText('#main', 'Kathryn Watson')
      .end();
  }
};