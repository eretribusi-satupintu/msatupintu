import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/user_model.dart';
import 'package:satupintu_app/model/user_update_form_model.dart';
import 'package:satupintu_app/services/user_services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is UserGet) {
        try {
          emit(UserLoading());
          final user = await UserServices().getUser();
          emit(UserSuccess(user));
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }

      if (event is UserCheckRequested) {
        try {
          await UserServices().getUser();
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }

      if (event is UserUpdate) {
        try {
          emit(UserLoading());
          final user =
              await UserServices().updateUser(event.userId, event.user);
          emit(UserUpdateSuccess(user));
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }
      if (event is UserPasswordUpdate) {
        try {
          emit(UserLoading());
          await UserServices().updatePassword(
              event.oldPassword, event.newPassword, event.confirmationPassword);

          emit(UserUpdatePasswordSuccess());
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }

      if (event is UserForgotPasswordUpdate) {
        try {
          emit(UserLoading());
          await UserServices().updateForgotPassword(
              event.phoneNumber, event.newPassword, event.confirmationPassword);

          emit(UserUpdatePasswordSuccess());
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }
    });

    // on<UserCheckRequested>((event, emit) async {
    //   try {
    //     await UserServices().getUser();
    //   } catch (e) {
    //     emit(UserFailed(e.toString()));
    //   }
    // });
  }
}
