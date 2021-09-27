// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

class SecureStorage {

  // final _storage = FlutterSecureStorage();

  Future writeData(String key, String value) async {
    return await FlutterKeychain.put(key: key, value: value);
  }

  Future readData(String key) async {
    return await FlutterKeychain.get(key: key);
  }

  Future deleteData(String key) async{
    return await FlutterKeychain.remove(key: key);
  }

  Future clear() async{
    return await FlutterKeychain.clear();
  }
}