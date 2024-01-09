import 'dart:io';

String fixture(String name) {
  print("currentDirectory $name");
  var currentDirectory = Directory.current.toString().replaceAll('\'', '');
  print("currentDirectory $currentDirectory");
  var lastDirectory = currentDirectory.split('/')[currentDirectory.split('/').length - 1];
  if (lastDirectory == 'test') {
    return File('fixture/$name').readAsStringSync();
  } else {
    return File('test/fixture/$name').readAsStringSync();
  }
}