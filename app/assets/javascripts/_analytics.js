window.analytics = window.analytics || {
  virtualPageView: function (path, title) {
    window.dataLayer.push({
      "event": "pageView",
      "virtualPageViewPath": path,
      "virtualPageViewTitle": title
    });
  }
}
