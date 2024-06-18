import 'package:contacts_app/data/repo/contacts_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactCubit extends Cubit<void> {
  AddContactCubit() : super(0);

  var contact_repo =
      ContactsDaoRepository(); // Repodan bir nesneye ihtiyacımız var

  Future<void> save(String person_name, String person_number,
      String person_email, String person_address) async {
    await contact_repo.save(person_name, person_number, person_email,
        person_address); // Repodaki fonksiyonu çalıştırdık
  }
}
