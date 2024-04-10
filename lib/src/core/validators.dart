final _callsignRegex = RegExp(r'[a-zA-Z0-9]{1,3}[0-9][a-zA-Z0-9]{0,3}[a-zA-Z]');

bool isValidCallsign(String? callsign){
  return _callsignRegex.hasMatch(callsign ?? '');
}