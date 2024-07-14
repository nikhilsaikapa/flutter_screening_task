part of 'user_bloc.dart';

@immutable
sealed class UserState {
  final List<User>? users;
  const UserState({this.users});
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoadedSuccess extends UserState {
  const UserLoadedSuccess({required super.users});
}
