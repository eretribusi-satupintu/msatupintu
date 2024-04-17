import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/login_form_model.dart';
import 'package:satupintu_app/model/user_auth_model.dart';
import 'package:satupintu_app/model/user_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:satupintu_app/services/user_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthLogin) {
        try {
          emit(AuthLoading());
          final user = await AuthService().login(event.data);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());
          final LoginFormModel data =
              await AuthService().getCredentialFromLocal();
          final token = await AuthService().getToken();
          final UserAuthModel user = await AuthService().login(data);
          print({"current_user": token});
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogout) {
        try {
          emit(AuthLoading());
          await AuthService().logout();
          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
    });
  }
}
