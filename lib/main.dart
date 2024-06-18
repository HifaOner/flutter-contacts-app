import 'package:contacts_app/ui/cubit/add_contact_cubit.dart';
import 'package:contacts_app/ui/cubit/details_cubit.dart';
import 'package:contacts_app/ui/cubit/home_cubit.dart';
import 'package:contacts_app/ui/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddContactCubit()),
        BlocProvider(create: (context) => DetailsCubit()),// artık cubit tüm uygulamada kullanılabilir hale geldi
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
      ),
    );
  }
}


