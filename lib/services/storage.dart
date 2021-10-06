import 'package:get_storage/get_storage.dart';

class SecureStorage {

  final box = GetStorage();

  Future writeData(String key, String value) async {
    return await box.write(key, value);
  }

  Future readData(String key) async {
    return await box.read(key);
  }

  Future deleteData(String key) async{
    return await box.remove(key);
  }

  Future clear() async{
    return await box.erase();
  }
}