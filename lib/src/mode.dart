/// Represents a ham radio communication mode
enum Mode {
  cw,
  ft8,
  ft4,
  rtty,
  na;

  /// parses Mode from a string
  static Mode fromString(String modeStr) {
    modeStr = modeStr.toUpperCase();
    switch (modeStr) {
      case 'FT8':
        {
          return Mode.ft8;
        }
      case 'FT4':
        {
          return Mode.ft4;
        }
      case 'CW':
        {
          return Mode.cw;
        }
      case 'RTTY':
        {
          return Mode.rtty;
        }
    }
    return Mode.na;
  }
}
