import 'package:contacts_app/data/entity/contacts.dart';
import 'package:contacts_app/data/repo/contacts_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<List<Contacts>> {
  HomeCubit() : super(<Contacts>[]);

  var contact_repo = ContactsDaoRepository();

  // CONTACTS LİST
  Future<void> loadContacts() async {
    // sadece arayüze veri göndercek o yüzden void yazdık (emit edecez)
    var list = await contact_repo.loadContacts();
    emit(list); // listeyi arayüüze gönder
  }

  Future<void> search(String searchWord) async {
    var list = await contact_repo.search(searchWord);
    emit(list);
  }


  // DELETE
  Future<void> delete(int person_id) async { // Kişi Silme Fonksiyonu
    await contact_repo.delete(person_id);
    await loadContacts(); // sildikten sonra arayüzü güncelleeriz
  }
}
