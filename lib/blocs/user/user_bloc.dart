import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/user_auth_model.dart';
import 'package:satupintu_app/model/user_model.dart';
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
