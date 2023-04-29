var newmanVersion = require('../../package.json').version;

/* globals it, describe, exec */
describe('CLI run options', function () {
    it('should work correctly without any extra options', function (done) {
        exec('node ./bin/newman.js run test/fixtures/run/single-get-request.json', done);
    });

    it('should display the current Newman version correctly', function (done) {
        exec('node ./bin/newman.js --version', function (code, stdout, stderr) {
            expect(code).be(0);
            expect(stdout).be(`${newmanVersion}\n`);
            expect(stderr).be('');
            done();
        });
    });

    it('should not work without a collection', function (done) {
        exec('node ./bin/newman.js run -e test/fixtures/run/simple-variables.json',
            function (code) {
                expect(code).be(1);
                done();
            });
    });

    it('should not work without any options', function (done) {
        exec('node ./bin/newman.js run', function (code) {
            expect(code).be(1);
            done();
        });
    });

    it('should fail a collection run with undefined test cases', function (done) {
        exec('node ./bin/newman.js run test/fixtures/run/undefined-test-checks.json', function (code) {
            expect(code).be(1);
            done();
        });
    });

    it('should handle invalid collection URLs correctly', function (done) {
        // eslint-disable-next-line max-len
        exec('node ./bin/newman.js run https://api.getpostman.com/collections/my-collection-uuid?apikey=my-secret-api-key', function (code) {
            expect(code).be(1);
            done();
        });
    });

    it('should correctly work with global variable overrides passed with --global-var', function (done) {
        // eslint-disable-next-line max-len
        exec('node ./bin/newman.js run test/integration/steph/steph.postman_collection.json --global-var first=James --global-var last=Bond', function (code) {
            expect(code).be(0);
            done();
        });
    });

    it('should throw an error for missing --global-var values', function (done) {
        // eslint-disable-next-line max-len
        exec('node ./bin/newman.js run test/integration/steph/steph.postman_collection.json --global-var', function (code, stdout, stderr) {
            expect(code).be(1);
            expect(stderr).to.be('\n  error: option `--global-var <value>\' argument missing\n\n');
            done();
        });
    });

    describe('script timeouts', function () {
        it('should be handled correctly when breached', function (done) {
            // eslint-disable-next-line max-len
            exec('node ./bin/newman.js run test/integration/timeout/timeout.postman_collection.json --timeout-script 5', function (code) {
                // .to.be.(1) is not used as the windows exit code can be an arbitrary non-zero value
                expect(code).be.above(0);
                done();
            });
        });

        it('should be handled correctly when not breached', function (done) {
            // eslint-disable-next-line max-len
            exec('node ./bin/newman.js run test/integration/timeout/timeout.postman_collection.json --timeout-script 500', function (code) {
                expect(code).be(0);
                done();
            });
        });
    });
});
