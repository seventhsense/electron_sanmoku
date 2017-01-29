(function() {
  var app, bw, create_window, electron, main_window;

  electron = require('electron');

  app = electron.app;

  bw = electron.BrowserWindow;

  main_window = null;

  create_window = function() {
    main_window = new bw({
      width: 300,
      height: 500
    });
    main_window.loadURL("file://" + __dirname + "/index.html");
    return main_window.on('closed', function() {
      return main_window = null;
    });
  };

  app.on('ready', function() {
    return create_window();
  });

  app.on('window-all-closed', function() {
    return app.quit();
  });

}).call(this);
