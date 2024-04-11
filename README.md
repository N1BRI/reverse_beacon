
# reverse_beacon

A simple dart library that transforms the reverse beacon telnet CW and DIGI servers into a controllable stream 

## Usage

```dart
import 'dart:io';

import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:reverse_beacon/src/band.dart';
import 'package:reverse_beacon/src/cw_spot.dart';
import 'package:reverse_beacon/src/exceptions.dart';
import 'package:reverse_beacon/src/mode.dart';

void main() async{
  var rb = ReverseBeacon();
  try{
    await rb.connect(callsign: 'n1bri');
  }
  on TelnetCommunicationException catch(_){
    print('Telnet Communication Exception');
    exit(-1);
  }
  on InvalidCallsignException catch(_){
    print('Invalid callsign');
    exit(-1);
  }
  catch(ex){
    print('unknown issue');
    exit(-1);
  }
  rb.controller.stream.listen((spot) {
    //filter
    if(spot.band == Band.meters20 && spot.mode == Mode.cw){
      if ((spot as CWSpot).wpm == 15){
        print(spot);
      }
    }
  });
}

```
