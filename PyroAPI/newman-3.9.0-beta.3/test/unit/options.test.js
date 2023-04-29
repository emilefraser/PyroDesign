var _ = require('lodash'),
    expect = require('expect.js'),
    options = require('../../lib/run/options');

describe('options', function () {
    describe('JSON with spaces', function () {
        it('should be handled correctly for collections', function (done) {
            var collection = require('../../test/fixtures/run/spaces/single-get-request.json');

            options({
                collection: './test/fixtures/run/spaces/single-get-request.json'
            }, function (err, result) {
                expect(err).to.be(null);

                // remove undefined properties
                result = JSON.parse(JSON.stringify(result.collection.toJSON()));
                expect(_.omit(result, ['event', 'info.id', 'variable', 'item.0.id', 'item.0.response'])).to
                    .eql(collection);
                done();
            });
        });

        it('should be handled correctly for environments', function (done) {
            var environment = require('../../test/fixtures/run/spaces/simple-variables.json');

            options({
                environment: './test/fixtures/run/spaces/simple-variables.json'
            }, function (err, result) {
                expect(err).to.be(null);

                expect(_.omit(result.environment.toJSON(), 'id')).to.eql(environment);
                done();
            });
        });

        it('should be handled correctly for globals', function (done) {
            var globals = require('../../test/fixtures/run/spaces/simple-variables.json');

            options({
                globals: './test/fixtures/run/spaces/simple-variables.json'
            }, function (err, result) {
                expect(err).to.be(null);

                expect(_.omit(result.globals.toJSON(), 'id')).to.eql(globals);
                done();
            });
        });

        it('should be handled correctly for iterationData', function (done) {
            var data = require('../../test/fixtures/run/spaces/data.json');

            options({
                iterationData: './test/fixtures/run/spaces/data.json'
            }, function (err, result) {
                expect(err).to.be(null);
                expect(result.iterationData).to.eql(data);
                done();
            });
        });
    });
});
