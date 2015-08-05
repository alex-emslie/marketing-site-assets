var path = require('path'),
	fs = require('fs'),
	sassEntryPoint = 'sass',
	sassDir = path.join(path.dirname(fs.realpathSync(__filename)), sassEntryPoint),
	neat = require('node-neat');

function includePaths(){
	return neat.with(sassDir)
}

module.exports = {
	includePaths: includePaths(),
	with: function(){
		var paths = Array.prototype.slice.call(arguments);
		var result = [].concat.apply(includePaths(), paths)
		return result
	}
}