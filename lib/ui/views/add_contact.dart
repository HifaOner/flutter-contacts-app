import 'package:contacts_app/ui/cubit/add_contact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {


  var tfContactName = TextEditingController();
  var tfContactNumber = TextEditingController();
  var tfContactEmail = TextEditingController();
  var tfContactAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Contact"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
          child: Column(
            children: [
              Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.white,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blue)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      // Save bastığımızda tect field bilgilerini kaydeder, konsola yazdırır
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blue)),
                      onPressed: () {
                        context.read<AddContactCubit>().save(
                            tfContactName.text,
                            tfContactNumber.text,
                            tfContactEmail.text,
                            tfContactAddress.text);
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
