const { environment } = require('@rails/webpacker')

const babelLoader = environment.loaders.get('babel')

babelLoader.exclude = /node_modules\/(?!(@hotwired))/ 

module.exports = environment
