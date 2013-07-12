require.config({
    paths: {
        jquery: '../bower_components/jquery/jquery',
        bootstrap: 'vendor/bootstrap',
        sha1: '../bower_components/codebird/sha1',
        codebird: '../bower_components/codebird/codebird',
        typeahead: '../bower_components/typeahead.js/dist/typeahead'
    },
    shim: {
        bootstrap: {
            deps: ['jquery'],
            exports: 'jquery'
        },
        codebird: {
            deps: ['sha1']
        },
        typeahead: {
            deps: ['jquery']
        }
    }
});

require(['app', 'jquery', 'bootstrap','sha1','codebird','typeahead'], function (app, $) {
    'use strict';
    console.log('Running jQuery %s', $().jquery);
});