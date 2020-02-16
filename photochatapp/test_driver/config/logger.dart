class Logger {
  void info(String msg, {String name}) {
    String logNamespace = 'unknown';
    if (name != null) {
      logNamespace = name;
    }
    print(msg + ' (' + logNamespace + ')');
  }
}

Logger logger = Logger();
