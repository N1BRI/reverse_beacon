import 'package:reverse_beacon/src/core/validators.dart';
import 'package:test/test.dart';

void main(){

  test('W1AW callsign should return true 1', (){
    expect(isValidCallsign('W1AW'), true);
  });

  test('W1N callsign should return true 2', (){
    expect(isValidCallsign('W1N'), true);
  });

  test('0x1ww callsign should return true 2', (){
    expect(isValidCallsign('0x1ww'), true);
  });
  
   test('ea3rc callsign should return true 2', (){
    expect(isValidCallsign('ea3rc'), true);
  });
  test('Wwwwwww callsign should return false', (){
    expect(isValidCallsign('Wwwwwww'), false);
  });

  test('empty string should return false', (){
    expect(isValidCallsign(''), false);
  });
}