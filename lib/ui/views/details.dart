import 'package:contacts_app/data/entity/contacts.dart';
import 'package:contacts_app/ui/cubit/details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Details extends StatefulWidget {
  Contacts person; // Contacts classından bir nesne geliyor
  Details(this.person);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  //var tfContactId = TextEditingController();
  var tfContactName = TextEditingController();
  var tfContactNumber = TextEditingController();
  var tfContactEmail = TextEditingController();
  var tfContactAddress = TextEditingController();

  @override
  void initState() {
    // initState fonksiyonu, bir Stateful widget'in durumunu başlatmak için kullanılan bir yöntemdir.
    // Stateful widget'ler, içeriklerinin değişebileceği ve yeniden çizilmesi gerekebileceği durumlar için kullanılır.
    super.initState();

    var person = widget.person;
    //var person = widget.person; ifadesinde, widget'in yapılandırıcısına
    // geçirilen person değerine erişmek istiyoruz. Bu sayede, person
    // değişkenini widget içinde kullanabiliriz.
    tfContactName.text = person.person_name;
    tfContactNumber.text = person.person_number;
    tfContactEmail.text = person.person_email;
    tfContactAddress.text = person.person_address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
          child: Column(
            children: [
              Container(
                  // Person Icon
                  width: 70,
                  height: 80,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  child: const Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 50,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 20),
                child: SizedBox(
                  child: TextFormField(
                    controller: tfContactName,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                        border: OutlineInputBorder(),
                        hintText: "Contact Name"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  child: TextFormField(
                    controller: tfContactNumber,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone, color: Colors.blue),
                        border: OutlineInputBorder(),
                        hintText: "Phone Number"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  child: TextFormField(
                    controller: tfContactEmail,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail, color: Colors.blue),
                        border: OutlineInputBorder(),
                        hintText: "E-Mail"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  child: TextFormField(
                    controller: tfContactAddress,
                    decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Icons.location_city, color: Colors.blue),
                        border: OutlineInputBorder(),
                        hintText: "Address"),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.blue)),
                  onPressed: () {
                    context.read<DetailsCubit>().update(
                        widget.person.person_id,
                        tfContactName.text,
                        tfContactNumber.text,
                        tfContactEmail.text,
                        tfContactAddress.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
