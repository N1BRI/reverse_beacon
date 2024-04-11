import 'package:reverse_beacon/src/mode.dart';
import 'package:test/test.dart';

void main() {
  test('ft8 should return FT8', () {
    expect(Mode.fromString('ft8'), Mode.ft8);
  });
  test('ft4 should return FT4', () {
    expect(Mode.fromString('ft4'), Mode.ft4);
  });
  test('cw should return CW', () {
    expect(Mode.fromString('cw'), Mode.cw);
  });
  test('rtty should return RTTY', () {
    expect(Mode.fromString('rtty'), Mode.rtty);
  });

  test('garbage should return NA', () {
    expect(Mode.fromString('sdsadsads'), Mode.na);
  });
}
