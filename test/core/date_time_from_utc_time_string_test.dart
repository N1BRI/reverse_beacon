import 'package:intl/intl.dart';
import 'package:reverse_beacon/src/core/utilities.dart';
import 'package:test/test.dart';

void main(){

  test('should return a datetime for today at 11:30', (){
    var tDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTimeFromUtcTimeString('1130'));
    var vDateTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now().toUtc().copyWith(hour: 11, minute: 30));
    expect(tDateTime, vDateTime);
  });

   test('should return a datetime for today at 21:12', (){
    var tDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTimeFromUtcTimeString('2112'));
    var vDateTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now().toUtc().copyWith(hour: 21, minute: 12));
    expect(tDateTime, vDateTime);
  });

   test('alpha input should return a datetime for today at 00:00', (){
    var tDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTimeFromUtcTimeString('sdassdasd'));
    var vDateTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now().toUtc().copyWith(hour: 00, minute: 00));
    expect(tDateTime, vDateTime);
  });

  test('empty input should return a datetime for today at 00:00', (){
    var tDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTimeFromUtcTimeString(''));
    var vDateTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now().toUtc().copyWith(hour: 00, minute: 00));
    expect(tDateTime, vDateTime);
  });
}