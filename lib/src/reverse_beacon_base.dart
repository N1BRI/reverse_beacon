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

/// A controller object that manages two telnet connections to telnet.reversebeacon.net
/// Creates and exposes one stream of spots from both digital and cw telnet servers
class ReverseBeacon {
  Socket? _cwSocket;
  Socket? _digiSocket;
  final StreamController<Spot> _controller = StreamController.broadcast();

  Future<void> connect({required callsign}) async {
    if (!isValidCallsign(callsign)) {
      throw InvalidCallsignException();
    }
    _cwSocket = await Socket.connect(host, cwPort,
        timeout: const Duration(seconds: timeout));
    _digiSocket = await Socket.connect(host, digiPort,
        timeout: const Duration(seconds: timeout));

    _cwSocket?.listen(onError: (error) => throw TelnetCommunicationException(),
        (event) {
      var spots = utf8
          .decode(event)
          .split('\n')
          .where((String s) => s.isNotEmpty)
          .toList();

      if (spots[0] == "Please enter your call: ") {
        _cwSocket?.add(utf8.encode('$callsign\r\n'));
      } else {
        spots = spots.where((e) => e.startsWith('DX')).toList();
        for (int i = 0; i < spots.length; i++) {
          Spot? spot;
          try {
            spot = CWSpot.fromTelnetText(spots[i]);
            _controller.add(spot);
          } catch (_) {} // garbage from telnet is possible
        }
      }
    });

    _digiSocket?.listen(
        onError: (error) => throw TelnetCommunicationException(), (event) {
      var spots = utf8
          .decode(event)
          .split('\n')
          .where((String s) => s.isNotEmpty)
          .toList();

      if (spots[0] == "Please enter your call: ") {
        _digiSocket?.add(utf8.encode('$callsign\r\n'));
      } else {
        spots = spots.where((e) => e.startsWith('DX')).toList();
        for (int i = 0; i < spots.length; i++) {
          Spot? spot;
          try {
            spot = DigiSpot.fromTelnetText(spots[i]);
            _controller.add(spot);
          } catch (_) {} // garbage from telnet is possible
        }
      }
    });
  }

  void listen(Function(Spot spot) onListen) {
    _controller.stream.listen(onListen);
  }

  void close() async {
    await _cwSocket?.close();
    await _digiSocket?.close();
    _controller.close();
  }
}
