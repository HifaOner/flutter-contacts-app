import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Kodlama çalışınca kopyalama yapar, erişim sağlar

  static const String dbName = "contacts.sqlite";

  static Future<Database> dbAccess() async {// veritabanına erişim fonksiyonu
    String dbPath = join(await getDatabasesPath(),
        dbName); // veri tabanının adıyla yoluna erişicez

    if (await databaseExists(dbPath)) {
      print("Veritabanı zaten var.Kopyalamaya gerek yok.");

    } else { // veritabanı kopyalama
      ByteData data = await rootBundle.load("database/$dbName"); // database dosyasıne erişiriz
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes); // listeyi bytea çeviriyoruz
      await File(dbPath).writeAsBytes(bytes, flush: true); // veritabanı yoluna byte kopyalıyoruz
      print("Veritabanı kopyalandı.");
    }
    return openDatabase(dbPath);
  }
}
