import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:reverse_beacon/src/core/validators.dart';
import 'package:reverse_beacon/src/cw_spot.dart';
import 'package:reverse_beacon/src/digi_spot.dart';
import 'package:reverse_beacon/src/exceptions.dart';

import 'spot.dart';

const String host = 'telnet.reversebeacon.net';
const int cwPort = 7000;
const int digiPort = 7001;
const int timeout = 25;

class ReverseBeacon {
  Socket? cwSocket;
  Socket? digiSocket;
  StreamController<Spot> controller = StreamController.broadcast();

  Future<void> connect({required callsign}) async {
    if (!isValidCallsign(callsign)) {
      throw InvalidCallsignException();
    }
    cwSocket = await Socket.connect(host, cwPort,
        timeout: const Duration(seconds: timeout));
    digiSocket = await Socket.connect(host, digiPort,
        timeout: const Duration(seconds: timeout));

    cwSocket?.listen(onError: (error) => throw TelnetCommunicationException(),
        (event) {
      var spots = utf8
          .decode(event)
          .split('\n')
          .where((String s) => s.isNotEmpty)
          .toList();

      if (spots[0] == "Please enter your call: ") {
        cwSocket?.add(utf8.encode('$callsign\r\n'));
      } else {
        spots = spots.where((e) => e.startsWith('DX')).toList();
        for (int i = 0; i < spots.length; i++) {
          controller.add(CWSpot.fromTelnetText(spots[i]));
        }
      }
    });

    digiSocket?.listen(onError: (error) => throw TelnetCommunicationException(),
        (event) {
      var spots = utf8
          .decode(event)
          .split('\n')
          .where((String s) => s.isNotEmpty)
          .toList();

      if (spots[0] == "Please enter your call: ") {
        digiSocket?.add(utf8.encode('$callsign\r\n'));
      } else {
        spots = spots.where((e) => e.startsWith('DX')).toList();
        for (int i = 0; i < spots.length; i++) {
          controller.add(DigiSpot.fromTelnetText(spots[i]));
        }
      }
    });
  }
}
