// ignore: library_prefixes
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:todo_list_provider/shared/errors/exceptions.dart';

class LocalStorageService {
  Future<void> set(String key, String? data) async {
    const storage = Storage.FlutterSecureStorage();

    try {
      storage.write(key: key, value: data);
    } catch (error, st) {
      final errorMessage = "Error storing data: $data with key: $key";
      log(errorMessage, error: error, stackTrace: st);
      throw LocalStorageException(errorMessage);
    }
  }

  Future<String?> get(String key) async {
    var storage = const Storage.FlutterSecureStorage();
    try {
      return await storage.read(key: key);
    } catch (error, st) {
      final errorMessage = "Error reading key: $key";
      log(errorMessage, error: error, stackTrace: st);
      throw LocalStorageException(errorMessage);
    }
  }

  Future<void> clearStorage() async {
    var storage = const Storage.FlutterSecureStorage();
    try {
      await storage.deleteAll();
    } catch (error, st) {
      const errorMessage = "Error clearing storage";
      log(errorMessage, error: error, stackTrace: st);
      throw LocalStorageException(errorMessage);
    }
  }
}
