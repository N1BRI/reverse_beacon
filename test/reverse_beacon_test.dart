import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:test/test.dart';

void main(){
  test('empty should return invalid callsign exception', () async{
    var tRb = ReverseBeacon();
    await expectLater(() async => await tRb.connect(callsign: ''), throwsA(TypeMatcher<InvalidCallsignException>()));
  });

   test('valid call should emit spots', () async{
    var tRb = ReverseBeacon();
    await tRb.connect(callsign: 'n1bri');
    tRb.listen((spot) {
      expect(spot, emits(TypeMatcher<Spot>()));
    });
  });
}