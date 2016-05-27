module.exports = {
  'Add a new coach,' : function (browser) {
    browser
      .url(process.env.WEB_SERVICE)
      .waitForElementVisible('a[id=newCoach]', 1000)
      .url(process.env.WEB_SERVICE + '/#/coaches/new')
      .waitForElementVisible('a[id=increaseSpot]', 1000)
      .click('a[id=increaseSpot]')
      .click('a[id=increaseSpot]')
      .click('a[id=increaseSpot]')
      .setValue('input[id=coachName]', 'Rodrigo Morais')
      .click('input[id=coachCheck]')
      .setValue('input[id=capabilities]', 'Elm e2e Nightwatch')
      .setValue('textarea[id=description]', 'Software Engineer')
      .click('button[id=saveCoach]')
      .pause(5000)
      .assert.containsText('#main', 'New coach created with success.');
  },

  'Search added coach' : function (browser) {
    browser
      .url(process.env.WEB_SERVICE)
      .waitForElementVisible('button[id=searchButton]', 1000)
      .click('button[id=searchButton]')
      .pause(1000)
      .assert.containsText('#main', 'Rodrigo Morais')
      .end();
  }
};