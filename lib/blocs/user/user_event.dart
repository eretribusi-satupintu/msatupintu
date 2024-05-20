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

class UserPasswordUpdate extends UserEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmationPassword;
  const UserPasswordUpdate(
    this.oldPassword,
    this.newPassword,
    this.confirmationPassword,
  );
}

class UserForgotPasswordUpdate extends UserEvent {
  final String phoneNumber;
  final String newPassword;
  final String confirmationPassword;
  const UserForgotPasswordUpdate(
    this.phoneNumber,
    this.newPassword,
    this.confirmationPassword,
  );
}
