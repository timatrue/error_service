const less = require('less');
const fs   = require('fs');
const path = require('path');

(function() {
    const src = "styles/main.less";
    less.render(fs.readFileSync(src).toString(), {
        filename: path.resolve(src),
    }, function(e, output) {
        console.log(output.css);
        fs.writeFile('./styles/main.css', output.css)
    });
})();