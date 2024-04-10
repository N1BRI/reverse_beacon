import 'dart:io';

List<String> fixtureFromTxt(String name) => File('test/fixtures/$name.txt').readAsLinesSync();