import 'dart:io';

import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:reverse_beacon/src/cw_spot.dart';
import 'package:reverse_beacon/src/reverse_beacon_base.dart';

void main() async {
  var rb = ReverseBeacon();
  try {
    await rb.connect(callsign: 'n1bri');
  } on TelnetCommunicationException catch (_) {
    print('Telnet Communication Exception');
    exit(-1);
  } on InvalidCallsignException catch (_) {
    print('Invalid callsign');
    exit(-1);
  } catch (ex) {
    print('unknown issue');
    exit(-1);
  }
  int spotCount = 0;
  rb.listen((spot) {
    //filter
    if (spotCount < 5) {
      if (spot.band == Band.meters20 && spot.mode == Mode.cw) {
        if ((spot as CWSpot).wpm >= 15) {
          print(spot);
          spotCount++;
        }
      }
    } else if (spotCount >= 5) {
      if (spot.band == Band.meters20 && spot.mode == Mode.ft8) {
        print(spot);
        spotCount++;
      }
    }

    if (spotCount == 10) {
      rb.close();
    }
  });
}
