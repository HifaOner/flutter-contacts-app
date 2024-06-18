import 'package:contacts_app/data/entity/contacts.dart';
import 'package:contacts_app/ui/cubit/home_cubit.dart';
import 'package:contacts_app/ui/views/add_contact.dart';
import 'package:contacts_app/ui/views/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // SEARCH
  bool isSearch = false; // Arama kısmının görünürlüğünü kontrol etme durumu

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeCubit>().loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearch // Eğer isSearch true ise aşağıdaki görünüm olacak
            ? TextField(
                decoration: const InputDecoration(hintText: "Search"),
                onChanged: (searchResult) {
                  context.read<HomeCubit>().search(searchResult);
                },
              )
            : const Text(
                "Contacts"), // Eğer isSearch false ise Contacts yazacaka

        actions: [
          isSearch
              ? IconButton(
                  // SEARCH GÖRÜNÜMÜNDE
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                    context.read<HomeCubit>().loadContacts();
                  },
                  icon:
                      const Icon(Icons.clear)) // Çarpıya basıldığında kapancak

              : IconButton(
                  // CONTACTS GÖRÜNÜMÜNDE
                  onPressed: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                  icon: const Icon(
                      Icons.search)) // Butona basıldığında arama kısmı açılcak
        ],
      ),

      // Bu sayfa, loadContacts fonksiyonundan gelecek olan kişi listesini (Contacts listesi) gösterir.
      // FutureBuilder widget'ı, bir Future nesnesinin dönüşünü bekler ve bu nesne dönene kadar bir
      // yüklenme ekranı veya bir hata mesajı gösterir. FutureBuilder ile yapılan iş, asenkron işlemler
      // sona erdikten sonra sayfayı güncellemektir. Bu sayede, loadContacts fonksiyonunun çalışması
      // tamamlanana kadar sayfa kullanıcıya bir yükleme durumu gösterir.

      body: BlocBuilder<HomeCubit, List<Contacts>>(
        //future: loadContacts(), // future parametresi, beklenen gelecekteki değeri temsil eden Future nesnesini belirtir
        builder: (context, contactsList) {
          // builder parametresi, Future nesnesi belirli bir duruma ulaştığında ne yapılacağını belirten bir fonksiyon alır
          if (contactsList.isNotEmpty) {
            // snapshot.hasData, Future nesnesi tamamlandığında true olur
            //var contactsList = snapshot.data; // snapshot.data, gelecekteki değeri temsil eden veriyi içerir
            return ListView.builder(
              // ListView.builder, bir liste oluşturmak için kullanılır
              itemCount: contactsList!.length, // Liste elemanlarının sayısı
              itemBuilder: (context, index) {
                var person = contactsList[index]; // Kişi bilgisi
                return GestureDetector(
                  onTap: () {
                    // Kişiye dokunulduğunda başka bir sayfaya geçiş yapılır
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(person)))
                        .then((value) {
                      context.read<HomeCubit>().loadContacts();
                      // Detay sayfasından geri dönüldüğünde bir işlem yapılır
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
                              // Çarpıya basıldığında silme snackbarı
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text("${person.person_name} will delete?"),
                                action: SnackBarAction(
                                  label: "Yes",
                                  onPressed: () {
                                    context
                                        .read<HomeCubit>()
                                        .delete(person.person_id);
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
            return const Center(
                child:
                    CircularProgressIndicator()); // Future nesnesi henüz tamamlanmadıysa yükleme durumunu göster
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        // ADD CONTACT SAYFASI GEÇİŞ BUTONU (+)
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddContact()))
              .then((value) {
            context.read<HomeCubit>().loadContacts();
            print("Anasayfaya dönüldü");
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
