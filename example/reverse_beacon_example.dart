import 'dart:developer';
import 'dart:io';

import 'package:reverse_beacon/reverse_beacon.dart';
import 'package:reverse_beacon/src/exceptions.dart';

void main() async{
  var rb = ReverseBeacon();
  try{
    await rb.connect(callsign: 'n1bri');
  }
  on SocketCommunicationException catch(ex){
    log(ex.toString());
    exit(-1);
  }
  rb.controller.stream.listen((spot) {
    print(spot);
  });
}
