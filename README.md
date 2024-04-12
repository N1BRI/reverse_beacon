
# reverse_beacon

A simple dart library that transforms the reverse beacon telnet CW and DIGI servers into a controllable broadcast stream.

This library is designed to be used in client applications, hence the exposed exception types.

Reverse Beacon: <https://www.reversebeacon.net/> **Support them if you can**

Reverse Beacon Telnet Server Info: <https://www.reversebeacon.net/pages/Telnet+servers+30> 

***this project is in no way officially associated or supported by Reverse Beacon, but I certainly appreciate everything they do. And obviously
this wouldn't work without them***

## Usage

```dart
import 'dart:io';

import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:reverse_beacon/src/cw_spot.dart';


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

```

**Output Ex.**
<pre>
skimmer: DL8TG, spotted: UD4D, wpm: 31, mode: Mode.cw , band: Band.meters20, freq: 14014.0 KHz, @11:35 , snr: 13, type: SpotType.cq
skimmer: HA8TKS, spotted: DL7DAX, wpm: 31, mode: Mode.cw , band: Band.meters20, freq: 14052.5 KHz, @11:35 , snr: 19, type: SpotType.cq
skimmer: DR4W, spotted: UD4D, wpm: 32, mode: Mode.cw , band: Band.meters20, freq: 14014.0 KHz, @11:35 , snr: 15, type: SpotType.cq
skimmer: IK4VET, spotted: DL7DAX, wpm: 31, mode: Mode.cw , band: Band.meters20, freq: 14052.5 KHz, @11:35 , snr: 16, type: SpotType.cq
skimmer: OG66X, spotted: UD4D, wpm: 32, mode: Mode.cw , band: Band.meters20, freq: 14014.0 KHz, @11:35 , snr: 10, type: SpotType.cq
skimmer: VU2CPL, spotted: JA2JKE, gridsquare: PM84, mode: Mode.ft8 , band: Band.meters20, freq: 14074.0 KHz, @11:35 , snr: -17, type: SpotType.cq
skimmer: VU2CPL, spotted: JF2RYX, gridsquare: N/A, mode: Mode.ft8 , band: Band.meters20, freq: 14074.0 KHz, @11:35 , snr: -19, type: SpotType.cq
skimmer: NG7M, spotted: W8UPI, gridsquare: EM85, mode: Mode.ft8 , band: Band.meters20, freq: 14074.0 KHz, @11:35 , snr: 0, type: SpotType.cq
skimmer: S50U, spotted: PD4SN, gridsquare: JO32, mode: Mode.ft8 , band: Band.meters20, freq: 14074.0 KHz, @11:35 , snr: -12, type: SpotType.cq
skimmer: S50U, spotted: PG7R, gridsquare: N/A, mode: Mode.ft8 , band: Band.meters20, freq: 14074.0 KHz, @11:35 , snr: -13, type: SpotType.cq

Exited.
</pre>