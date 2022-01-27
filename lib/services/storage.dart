// import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  // final box = GetStorage();
  // Create storage
  final storage = new FlutterSecureStorage();

  Future writeData(String key, String value) async {
    return await storage.write(key: key, value: value);
    // return await box.write(key, value);
  }

  Future readData(String key) async {
    return await storage.read(key: key);
    // return await box.read(key);
  }

  Future deleteData(String key) async{
    return await storage.delete(key: key);
    // return await box.remove(key);
  }

  Future clear() async{
    return await storage.deleteAll();
    // return await box.erase();
  }
}


