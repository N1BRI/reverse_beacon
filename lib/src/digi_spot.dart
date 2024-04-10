import 'package:intl/intl.dart';
import 'package:reverse_beacon/src/spot.dart';
import 'package:reverse_beacon/src/spot_type.dart';
import 'package:reverse_beacon/src/core/utilities.dart';

class DigiSpot extends Spot {
  final String? gridSquare;
  const DigiSpot(
      {this.gridSquare,
      required super.skimmerCall,
      required super.frequency,
      required super.spottedCall,
      required super.mode,
      required super.db,
      required super.time,
      required super.spotType});

   factory DigiSpot.fromTelnetText(String spotText) {
    var tokens = spotText.split(" ").where((t) => t.isNotEmpty).toList();
    
    return DigiSpot(
        skimmerCall: tokens[2].replaceFirst('-#:', ''),
        frequency: double.tryParse(tokens[3]) ?? 0,
        spottedCall: tokens[4],
        mode: tokens[5],
        db: int.tryParse(tokens[6]) ?? 0,
        gridSquare: tokens.length == 10 ? "N/A" : tokens[8],
        time: dateTimeFromUtcTimeString(tokens.last.length >= 4 ? tokens.last.substring(0,4) : "N/A"),
        spotType: tokens.length == 10 ? fromString(tokens[8]) : fromString(tokens[9]));
  }

  @override
  String toString(){
    return "skimmer: $skimmerCall, spotted: $spottedCall, grid square: $gridSquare , freq: $frequency KHz, @${DateFormat('HH:mm').format(time)} , snr: $db, type: $spotType";
  }
}
