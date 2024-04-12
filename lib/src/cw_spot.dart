import 'package:intl/intl.dart';
import 'package:reverse_beacon/src/band.dart';
import 'package:reverse_beacon/src/mode.dart';
import 'package:reverse_beacon/src/spot_type.dart';
import 'package:reverse_beacon/src/core/utilities.dart';

import 'spot.dart';

/// Represents an CW or RTTY spot
class CWSpot extends Spot {
  final int wpm;
  const CWSpot(
      {required this.wpm,
      required super.skimmerCall,
      required super.frequency,
      required super.band,
      required super.spottedCall,
      required super.mode,
      required super.db,
      required super.time,
      required super.spotType});

  factory CWSpot.fromTelnetText(String spotText) {
    var tokens = spotText.split(" ").where((t) => t.isNotEmpty).toList();
    var freq = double.tryParse(tokens[3]) ?? 0;
    return CWSpot(
        skimmerCall: tokens[2].replaceFirst('-#:', ''),
        frequency: freq,
        band: Band.getBand(freq),
        spottedCall: tokens[4],
        mode: Mode.fromString(tokens[5]),
        db: int.tryParse(tokens[6]) ?? 0,
        wpm: int.tryParse(tokens[8]) ?? 0,
        time: dateTimeFromUtcTimeString(
            tokens.last.length >= 4 ? tokens.last.substring(0, 4) : "N/A"),
        spotType: SpotType.fromString(tokens[10]));
  }

  @override
  String toString() {
    return "skimmer: $skimmerCall, spotted: $spottedCall, wpm: $wpm, mode: $mode , band: $band, freq: $frequency KHz, @${DateFormat('HH:mm').format(time)} , snr: $db, type: $spotType";
  }
}
