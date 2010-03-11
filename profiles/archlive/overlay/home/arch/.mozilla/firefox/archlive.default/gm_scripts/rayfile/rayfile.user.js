// ==UserScript==
// @name	rayfile
// @include	http://www.rayfile.com/*
// ==/UserScript==

var req = new XMLHttpRequest();
req.open('GET', document.getElementsByClassName('btn_indown_zh-cn')[0].childNodes[0].href, false);
req.send(null);

var r = req.responseText;

var cookie = r.match(/'ROXCDNKEY[^)]*/)[0].replace(/'/g,'').split(',');
document.cookie = cookie[0] + '=' + cookie[1] + ';path=' + cookie[3] + ';domain=' + cookie[4];

var url = r.match(/http:..cachefile\d*[^']*/);
document.getElementById('tabinfo_3').innerHTML = '<a href="' + url + '">下载</a>';

window.location = url;