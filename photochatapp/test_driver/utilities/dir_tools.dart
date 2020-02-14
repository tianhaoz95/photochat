import 'dart:io';

Future<void> createDirIfNotExist(String path) async {
  if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
    await Directory(path).create(recursive: true);
  }
}

Future<void> removeDirIfExist(String path) async {
  if (FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound) {
    await Directory(path).delete(recursive: true);
  }
}