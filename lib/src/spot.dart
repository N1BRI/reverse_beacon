import 'package:reverse_beacon/src/band.dart';
import 'package:reverse_beacon/src/mode.dart';
import 'package:reverse_beacon/src/spot_type.dart';

class Spot {
  final String skimmerCall;
  final double frequency;
  final String spottedCall;
  final Mode mode;
  final Band? band;
  final int db;
  final DateTime time;
  final SpotType spotType;
  
  const Spot(
      {required this.skimmerCall,
      required this.frequency,
      required this.spottedCall,
      required this.mode,
      required this.band,
      required this.db,
      required this.time,
      required this.spotType});
}
