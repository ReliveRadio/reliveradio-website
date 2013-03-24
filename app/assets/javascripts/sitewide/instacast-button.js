(function() {
  var didLoad, initButton;

  initButton = function(button) {
    var d, iframe, iframe_css, iframe_src, iframe_width, url;
    d = document.createElement('div');
    d.className = 'instacast-button';
    d.style.cssText = 'overflow:hidden;display:inline-block;';
    url = button.href;
    iframe = document.createElement('iframe');
    iframe.setAttribute('seamless', 'seamless');
    iframe.setAttribute('frameborder', '0');
    iframe.setAttribute('scrolling', 'no');
    iframe_src = "http://b.instaca.st/button?url=" + url;
    iframe_width = 'width:140px;';
    if (button.className.indexOf('instacast-button-orange') > -1) {
      iframe_src += '&style=orange';
    }
    if (button.className.indexOf('instacast-button-no-counter') > -1) {
      iframe_src += '&no_counter=1';
      iframe_width = 'width:80px;';
    }
    iframe_css = "border:none;overflow:hidden;height:20px;" + iframe_width;
    console.log(iframe_css);
    iframe.style.cssText = iframe_css;
    iframe.src = iframe_src;
    d.appendChild(iframe);
    return button.parentNode.replaceChild(d, button);
  };

  didLoad = function() {
    var e, _i, _j, _len, _len1, _ref, _ref1, _results, _results1;
    if (document.addEventListener) {
      document.removeEventListener('load', didLoad, false);
      document.removeEventListener('DOMContentLoaded', didLoad, false);
    }
    if (window.detachEvent) {
      window.detachEvent('onload', didLoad);
    }
    if (document.querySelectorAll) {
      _ref = document.querySelectorAll('a.instacast-button');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        e = _ref[_i];
        _results.push(initButton(e));
      }
      return _results;
    } else {
      _ref1 = document.getElementsByTagName('a');
      _results1 = [];
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        e = _ref1[_j];
        if (e.className === 'instacast-button') {
          _results1.push(initButton(e));
        } else {
          _results1.push(void 0);
        }
      }
      return _results1;
    }
  };

  if (window.attachEvent) {
    window.attachEvent('onload', didLoad);
  } else if (window.addEventListener) {
    window.addEventListener('DOMContentLoaded', didLoad, false);
    window.addEventListener('load', didLoad, false);
  }

}).call(this);
