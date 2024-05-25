import 'package:contacts_app/data/entity/contacts.dart';
import 'package:contacts_app/ui/views/add_contact.dart';
import 'package:contacts_app/ui/views/details.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearch = false;

  Future<void> search(String searchWord) async {
    print("Search : $searchWord");
  }

  Future<List<Contacts>> loadContacts() async {
    var contactsList = <Contacts>[];

    var p1 = Contacts(
        person_id: 1,
        person_name: "Theo James",
        person_number: "212- 111- 2233",
        person_email: "theojames@gmail.com",
        person_address: "Holland, Amsterdam");
    var p2 = Contacts(
        person_id: 2,
        person_name: "Steve Perry",
        person_number: "212- 222- 3344",
        person_email: "stveperry@hotmail.com",
        person_address: "New York, USA");
    var p3 = Contacts(
        person_id: 3,
        person_name: "John Barnes",
        person_number: "212- 333- 4455",
        person_email: "johnbarnes@gmail.com",
        person_address: "Italy, Rome");
    contactsList.add(p1);
    contactsList.add(p2);
    contactsList.add(p3);
    return contactsList;
  }

  Future<void> delete(int person_id) async {
    print("Deleted Person : $person_id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? TextField(
                decoration: const InputDecoration(hintText: "Search"),
                onChanged: (searchResult) {
                  search(searchResult);
                },
              )
            : const Text("Contacts"),
        actions: [
          isSearch
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                  },
                  icon: const Icon(Icons.clear))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                  icon: const Icon(Icons.search))
        ],
      ),
      body: FutureBuilder<List<Contacts>>(
        future: loadContacts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var contactsList = snapshot.data;
            return ListView.builder(
              itemCount: contactsList!.length,
              itemBuilder: (context, index) {
                var person = contactsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(person)))
                        .then((value) {
                      print("Back to HomePage");
                    });
                  },
                  child: Card(
                    color: Colors.white70,
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  person.person_name,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  person.person_number,
                                  style: const TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text("${person.person_name} will delete?"),
                                action: SnackBarAction(
                                  label: "Yes",
                                  onPressed: () {
                                    delete(person.person_id);
                                  },
                                ),
                              ));
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddContact()))
              .then((value) {
            print("Anasayfaya dönüldü");
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
