DateTime dateTimeFromUtcTimeString(String zuluTime) {
  int hours = 00;
  int minutes = 00;
if(zuluTime.runes.length == 4){
    hours = int.tryParse(zuluTime.substring(0, 2)) ?? 00;
    minutes = int.tryParse(zuluTime.substring(2, 4)) ?? 00;
  }
  return DateTime.now().toUtc().copyWith(hour: hours, minute: minutes);
}
