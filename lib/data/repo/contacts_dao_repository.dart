import 'package:contacts_app/data/entity/contacts.dart';
import 'package:contacts_app/sqlite/database_helper.dart';

class ContactsDaoRepository {
  // SAVE
  Future<void> save(String person_name, String person_number,
      String person_email, String person_address) async {
    var db = await DatabaseHelper.dbAccess();
    var newPerson = Map<String, dynamic>();
    newPerson["person_name"] = person_name;
    newPerson["person_number"] = person_number;
    newPerson["person_email"] = person_email;
    newPerson["person_address"] = person_address;
    await db.insert("contacts", newPerson);
  }

  // UPDATE
  Future<void> update(int person_id, String person_name, String person_number,
      String person_email, String person_address) async {
    var db = await DatabaseHelper.dbAccess();
    var updatedPerson = Map<String, dynamic>();
    updatedPerson["person_name"] = person_name;
    updatedPerson["person_number"] = person_number;
    updatedPerson["person_email"] = person_email;
    updatedPerson["person_address"] = person_address;
    await db.update("contacts", updatedPerson,
        where: "person_id = ?", whereArgs: [person_id]);
  }

  // DELETE
  Future<void> delete(int person_id) async {
    // Kişi Silme Fonksiyonu
    var db = await DatabaseHelper.dbAccess();
    await db.delete("contacts", where: "person_id = ?", whereArgs: [person_id]);
  }

  // CONTACTS LİST
  Future<List<Contacts>> loadContacts() async {
    // Kişileri List İçinde Yükleme Fonksiyonu
    //loadContacts fonksiyonu kişileri yüklemek için kullanılacak.
    // Gerçek dünyada, bu işlem bir veritabanından veri çekmek veya
    // bir API'den veri almak gibi işlemleri içerebilir.

    var db = await DatabaseHelper.dbAccess();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM contacts");

    return List.generate(maps.length, (i) {
      var row = maps[i];
      return Contacts(
          person_id: row["person_id"],
          person_name: row["person_name"],
          person_number: row["person_number"],
          person_email: row["person_email"],
          person_address: row["person_address"]);
    });
  }

  Future<List<Contacts>> search(String searchWord) async {
    var db = await DatabaseHelper.dbAccess();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM contacts WHERE person_name like '%$searchWord%'");

    return List.generate(maps.length, (i) {
      var row = maps[i];
      return Contacts(
          person_id: row["person_id"],
          person_name: row["person_name"],
          person_number: row["person_number"],
          person_email: row["person_email"],
          person_address: row["person_address"]);
    });
  }
}
