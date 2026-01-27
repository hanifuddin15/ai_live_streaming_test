class LogBracket {
  static const objOpen = '⦃';
  static const objClose = '⦄';
  static const arrOpen = '⟦';
  static const arrClose = '⟧';
}

class LogAnsi {
  static const reset = '\x1B[0m';
  static const key = '\x1B[33m'; // yellow
  static const string = '\x1B[36m'; // cyan
  static const number = '\x1B[35m'; // magenta
  static const boolVal = '\x1B[32m'; // green
  static const nullVal = '\x1B[31m'; // red
}
