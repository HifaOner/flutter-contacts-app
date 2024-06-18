import 'package:contacts_app/data/repo/contacts_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsCubit extends Cubit<void> {
  DetailsCubit() : super(0);

  var contact_repo =
      ContactsDaoRepository(); // Repodan bir nesneye ihtiyacımız var

// UPDATE
  Future<void> update(int person_id, String person_name, String person_number,
      String person_email, String person_address) async {
    await contact_repo.update(
        person_id, person_name, person_number, person_email, person_address);
  }
}
