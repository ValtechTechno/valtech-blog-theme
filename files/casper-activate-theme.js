casper.test.begin('Automate activation of theme', 4, function suite(test) {
    casper.start('http://<%= clientIP %>', function() {
        test.assertTitle('Valtech Blog | Just another WordPress site');
        this.clickLabel('Log in');
    });

    casper.then(function() {
        this.fill('form#loginform', {
            'log': '<%= login %>',
            'pwd': '<%= password %>'
        }, true);
    });

    casper.then(function () {
        test.assertTitle('Dashboard ‹ Valtech Blog — WordPress');
        this.clickLabel('Appearance');
    });

    casper.then(function () {
        test.assertTitle('Manage Themes ‹ Valtech Blog — WordPress');
        this.click("a.activatelink[title='Activate “Valtech One”']");
    });

    casper.then(function () {
        test.assertSelectorHasText('div#current-theme h4', 'Valtech One 0.1 by Eric Le Merdy, Valtech')
    });

	casper.run(function() {
        test.done();
    });
});