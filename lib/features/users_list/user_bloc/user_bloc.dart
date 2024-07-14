import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../models/users_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  Users? _users;
  Users? get users => _users;
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoadUsers) {
        if (_users == null || (_users!.page < _users!.total_pages)) {
          emit(UserLoading());
          final currentPage = _users?.page ?? 0;
          List<User>? newUsers = await fetchUsers(currentPage + 1);
          if (newUsers == null) {
            emit(UserLoadedSuccess(users: newUsers));
          } else {
            final List<User> newList = [];
            newList.addAll(event.users);
            newList.addAll(newUsers);
            emit(UserLoadedSuccess(users: newList));
          }
        }
      }
    });
  }

  Future<List<User>?> fetchUsers(int page) async {
    try{
      final result =
      await http.get(Uri.parse("https://reqres.in/api/users?page=$page"));
      final Users users =
      Users.fromJson(jsonDecode(result.body) as Map<String, dynamic>);
      _users = users;
      return users.data;
    }catch(_){
      return null;
    }
  }
}
