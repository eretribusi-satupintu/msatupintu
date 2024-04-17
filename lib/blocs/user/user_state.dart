part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final UserModel data;
  const UserSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class UserFailed extends UserState {
  final String e;
  const UserFailed(this.e);

  @override
  List<Object> get props => [e];
}
