window.analytics = window.analytics || {
  virtualPageView: function (path) {
    window.dataLayer.push({"event": "pageView", "virtualPageViewPath": path});
  }
}
