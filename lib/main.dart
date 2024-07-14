import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/users_list/user_bloc/user_bloc.dart';
import 'features/users_list/widgets/users_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'SFProDisplay',
      ),
      home: BlocProvider<UserBloc>(
        create: (context) => UserBloc(),
        child: const UsersListPage(),
      ),
    );
  }
}
