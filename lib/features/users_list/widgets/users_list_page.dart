import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screening_task/features/users_list/models/users_model.dart';

import '../user_bloc/user_bloc.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  late UserBloc userBloc;
  final pageBucket = PageStorageBucket();
  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(LoadUsers(users: const []));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: const Text('Users List'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.users == null) {
            return const Center(
              child: Text('No Users Found'),
            );
          }
          final List<Widget> items =
              List.generate(state.users!.length, (index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 32.0,
                backgroundImage: NetworkImage(state.users![index].avatar),
              ),
              title: Text(
                  "${state.users![index].first_name} ${state.users![index].last_name}"),
              subtitle: Text(state.users![index].email),
            );
          });
          return PageStorage(
            bucket: pageBucket,
            child: SingleChildScrollView(
              key: const PageStorageKey<String>("Users List"),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: items,
                  ),
                  Visibility(
                      visible: !(userBloc.users?.isAllUsersLoaded() ?? false),
                      child: TextButton(
                          onPressed: () {
                            userBloc.add(LoadUsers(users: state.users ?? []));
                          },
                          child: const Text('Load More')))
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
