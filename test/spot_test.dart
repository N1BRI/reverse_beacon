import 'package:reverse_beacon/src/cw_spot.dart';
import 'package:reverse_beacon/src/digi_spot.dart';
import 'package:test/test.dart';


import 'fixtures/fixture.dart';

void main(){

group('fromTelnetText', (){
    test('should return a valid cw spot', (){
      var spotTxt = fixtureFromTxt('cw_spots');
      var result = CWSpot.fromTelnetText(spotTxt.first);
      expect(result.toString(), 'skimmer: ZF9CW, spotted: K5MR, wpm: 38 , freq: 14042.6 KHz, @18:54 , snr: 18, type: SpotType.cq');
    });

    test('should return a valid beacon type cw spot', (){
      var spotTxt = fixtureFromTxt('cw_spots');
      var result = CWSpot.fromTelnetText(spotTxt[1]);
      expect(result.toString(), 'skimmer: KV4TT, spotted: WY7DT/B, wpm: 12 , freq: 28260.0 KHz, @18:54 , snr: 8, type: SpotType.beacon');
    });

     test('should return a valid NCDXF type cw spot', (){
      var spotTxt = fixtureFromTxt('cw_spots');
      var result = CWSpot.fromTelnetText(spotTxt[2]);
      expect(result.toString(), 'skimmer: W1NT-6, spotted: YV5B, wpm: 22 , freq: 21150.0 KHz, @18:54 , snr: 11, type: SpotType.ncdxf');
    });

    test('should return a valid digi mode spot with N/A gridsquare', (){
      var spotTxt = fixtureFromTxt('digi_spots');
      var result = DigiSpot.fromTelnetText(spotTxt.first);
      expect(result.toString(), 'skimmer: G4IRN, spotted: RM9WU, grid square: N/A , freq: 7074.0 KHz, @18:53 , snr: 1, type: SpotType.cq');
    });

    test('should return a valid digi mode spot with JO22 gridsquare', (){
      var spotTxt = fixtureFromTxt('digi_spots');
      var result = DigiSpot.fromTelnetText(spotTxt[1]);
      expect(result.toString(), 'skimmer: G4IRN, spotted: PD0IDQ, grid square: JO22 , freq: 7074.0 KHz, @18:53 , snr: -6, type: SpotType.cq');
    });

  });

}