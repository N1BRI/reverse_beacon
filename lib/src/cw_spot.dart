import 'package:intl/intl.dart';
import 'package:reverse_beacon/src/spot_type.dart';
import 'package:reverse_beacon/src/core/utilities.dart';

import 'spot.dart';

class CWSpot extends Spot {
  final int wpm;
  const CWSpot(
      {required this.wpm,
      required super.skimmerCall,
      required super.frequency,
      required super.spottedCall,
      required super.mode,
      required super.db,
      required super.time,
      required super.spotType});

  factory CWSpot.fromTelnetText(String spotText) {
    var tokens = spotText.split(" ").where((t) => t.isNotEmpty).toList();
    return CWSpot(
        skimmerCall: tokens[2].replaceFirst('-#:', ''),
        frequency: double.tryParse(tokens[3]) ?? 0,
        spottedCall: tokens[4],
        mode: tokens[5],
        db: int.tryParse(tokens[6]) ?? 0,
        wpm: int.tryParse(tokens[8]) ?? 0,
        time: dateTimeFromUtcTimeString(tokens.last.length >= 4 ? tokens.last.substring(0,4) : "N/A"),
        spotType: fromString(tokens[10]));
  }

  @override
  String toString(){
    return "skimmer: $skimmerCall, spotted: $spottedCall, wpm: $wpm , freq: $frequency KHz, @${DateFormat('HH:mm').format(time)} , snr: $db, type: $spotType";
  }
}
