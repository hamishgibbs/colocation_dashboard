
var marked = require('marked');
var fs = require('fs');

var readMe = fs.readFileSync('/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/UK/text/description.md', 'utf-8');
var markdownReadMe = marked(readMe);

fs.writeFileSync('/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/UK/text/description.html', markdownReadMe);
