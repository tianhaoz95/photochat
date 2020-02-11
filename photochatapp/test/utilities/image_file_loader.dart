import 'dart:io';

File loadFixtureImageFile(String filename) {
  String pathRelativeToRoot = './test/fixtures/' + filename;
  String pathRelativeToTest = './fixtures/' + filename;
  if (FileSystemEntity.typeSync(pathRelativeToRoot) !=
      FileSystemEntityType.notFound) {
    File imageFileRelativeToRoot = File(pathRelativeToRoot);
    return imageFileRelativeToRoot;
  } else if (FileSystemEntity.typeSync(pathRelativeToTest) !=
      FileSystemEntityType.notFound) {
    File imageFileRelativeToTest = File(pathRelativeToTest);
    return imageFileRelativeToTest;
  } else {
    throw 'wtf';
  }
}
