CodeMirror.requireMode('clike',function(){
    "use strict";

    CodeMirror.defineMode("scala", function(conf, parserConf) {
        var scalaConf = {};
        for (var prop in parserConf) {
            if (parserConf.hasOwnProperty(prop)) {
                scalaConf[prop] = parserConf[prop];
            }
        }

        scalaConf.name = 'text/x-scala';

        var mode = CodeMirror.getMode(conf, scalaConf);

        return mode;
    }, 'scala');

    CodeMirror.defineMIME("text/x-spark", "spark", "scala");
})
