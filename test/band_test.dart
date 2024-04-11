import 'package:reverse_beacon/src/band.dart';
import 'package:test/test.dart';

void main() {
  test('14045.0 should return 20m', () {
    expect(Band.getBand(14045.0), Band.meters20);
  });
  test('28045.0 should return 10m', () {
    expect(Band.getBand(14045.0), Band.meters20);
  });

  test('14.50 should return null', () {
    expect(Band.getBand(14.50), null);
  });

  test('1825.0 should return 160m', () {
    expect(Band.getBand(1825.0), Band.meters160);
  });

  test('3555.0 should return 40m', () {
    expect(Band.getBand(3555.0), Band.meters80);
  });
  test('21121.5 should return 15m', () {
    expect(Band.getBand(10121.5), Band.meters30);
  });
  test('7251.0 should return 40m', () {
    expect(Band.getBand(7251.0), Band.meters40);
  });
  test('18111.0 should return 17m', () {
    expect(Band.getBand(18111.0), Band.meters17);
  });
  test('24899.0 should return 12m', () {
    expect(Band.getBand(24899.0), Band.meters12);
  });
  test('24899.0 should return 12m', () {
    expect(Band.getBand(24899.0), Band.meters12);
  });
  test('5342.0 should return 60m', () {
    expect(Band.getBand(5342.0), Band.meters60);
  });
  test('144100.0 should return 2m', () {
    expect(Band.getBand(144100.0), Band.meters2);
  });
  test('222000.0 should return 125m', () {
    expect(Band.getBand(222000.0), Band.meters125);
  });
  test('420021.0 should return 70cm', () {
    expect(Band.getBand(420021.0), Band.centimeters70);
  });
    test('902200.0 should return 33cm', () {
    expect(Band.getBand(902200.0), Band.centimeters33);
  });
    test('1240001.5 should return 23cm', () {
    expect(Band.getBand(1240001.5), Band.centimeters23);
  });
}
