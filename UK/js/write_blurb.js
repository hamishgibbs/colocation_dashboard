var marked = require('marked');
var fs = require('fs');

var readMe = fs.readFileSync('/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/UK/text/blurb.md', 'utf-8');
var markdownReadMe = marked(readMe);

fs.writeFileSync('/Users/hamishgibbs/Documents/Covid-19/colocation_dashboard/UK/text/blurb.html', markdownReadMe);
