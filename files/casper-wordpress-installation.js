casper.test.begin('Automate install wordpress final install step', 2, function suite(test) {
    casper.start('http://10.10.10.2', function() {
        test.assertTitle('WordPress › Installation');
        this.fill('form#setup', {
            'weblog_title': 'Valtech Blog',
            'admin_password': 'admin',
            'admin_password2': 'admin',
            'admin_email': 'postmaster@exemple.com',
            'blog_public': false
        }, true);
    });

    casper.then(function() {
        test.assertSelectorContains('h1', 'Success!');
    });

	casper.run(function() {
        test.done();
    });
});