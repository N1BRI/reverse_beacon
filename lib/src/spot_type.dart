/// Represents a spot type as identified by reverse beacon network
enum SpotType {
  cq,
  beacon,
  b,
  dx,
  ncdxf,
  unknown;

  /// converts a string to a spot type
  static SpotType fromString(String rawType) {
    switch (rawType.toUpperCase().split(' ').first) {
      case 'CQ':
        return SpotType.cq;
      case 'BEACON':
        return SpotType.beacon;
      case 'B':
        return SpotType.b;
      case 'DX':
        return SpotType.dx;
      case 'NCDXF':
        return SpotType.ncdxf;
      default:
        return SpotType.unknown;
    }
  }
}
