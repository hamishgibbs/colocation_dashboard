var _args = process.argv

var marked = require('marked');
var fs = require('fs');

var readMe = fs.readFileSync(_args[2], 'utf-8');
var markdownReadMe = marked(readMe);

fs.writeFileSync(_args[3], markdownReadMe);

console.log('Success.')