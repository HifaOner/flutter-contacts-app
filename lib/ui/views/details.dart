import 'package:contacts_app/data/entity/contacts.dart';
import 'package:flutter/material.dart';

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

  Future<void> update(int person_id, String person_name, String person_number,
      String person_email, String person_address) async {
    print(
        "Contact Updated! : $person_id - $person_name - $person_number - $person_email - $person_address ");
  }

  @override
  void initState() {
    super.initState();

    var person = widget.person;
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
                        update(
                            widget.person.person_id,
                            tfContactName.text,
                            tfContactNumber.text,
                            tfContactEmail.text,
                            tfContactAddress.text);
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
