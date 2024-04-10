import 'package:reverse_beacon/reverse_beacon.dart';

void main() async{
  var rb = ReverseBeacon();
  await rb.connect(callsign: 'n1bri');
  rb.controller?.stream.listen((spot) {
    print(spot);
  });
}
