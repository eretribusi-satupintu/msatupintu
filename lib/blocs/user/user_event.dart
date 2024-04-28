part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserGet extends UserEvent {}

class UserCheckRequested extends UserEvent {}

class UserUpdate extends UserEvent {
  final int userId;
  final UserUpdateFormModel user;
  const UserUpdate(this.user, this.userId);
}
