casper.test.begin('Automate install wordpress final install step', 2, function suite(test) {
    casper.start('http://<%= clientIP %>', function() {
        test.assertTitle('WordPress › Installation');
        this.fill('form#setup', {
            'weblog_title': 'Valtech Blog',
            'user_name': '<%= login %>',
            'admin_password': '<%= password %>',
            'admin_password2': '<%= password %>',
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