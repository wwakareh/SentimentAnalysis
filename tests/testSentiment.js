/*global require, describe, it, before */
require("should");
var sentiment = require('sentiment');

describe('Sentiment tests', function() {
	it('should return a positive sentiment for "good"', function(done) {
		sentiment("good", function (err, result) {
			if (err) {
				throw err;
			} else {
				result.score.should.be.above(0);
			}
			done();
        });
	});
	it('should return a negative sentiment for "bad"', function(done) {
		sentiment("bad", function (err, result) {
			if (err) {
				throw err;
			} else {
				result.score.should.be.below(0);
			}
			done();
        });
	});
});