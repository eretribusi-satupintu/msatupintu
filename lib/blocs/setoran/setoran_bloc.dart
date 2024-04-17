import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/setoran_form_model.dart';
import 'package:satupintu_app/model/setoran_model.dart';
import 'package:satupintu_app/services/setoran_services.dart';

part 'setoran_event.dart';
part 'setoran_state.dart';

class SetoranBloc extends Bloc<SetoranEvent, SetoranState> {
  SetoranBloc() : super(SetoranInitial()) {
    on<SetoranEvent>((event, emit) async {
      if (event is SetoranGet) {
        try {
          emit(SetoranLoading());
          final setoran = await SetoranServices().getSetoran();
          emit(SetoranSuccess(setoran));
        } catch (e) {
          emit(SetoranFailed(e.toString()));
        }
      }
      if (event is SetoranPost) {
        try {
          emit(SetoranLoading());
          final setoran = await SetoranServices().postSetoran(event.data);
          emit(SetoranDetailSuccess(setoran));
        } catch (e) {
          emit(
            SetoranFailed(
              e.toString(),
            ),
          );
        }
      }
      if (event is SetoranUpdate) {
        try {
          emit(SetoranLoading());
          final setoran =
              await SetoranServices().updateSetoran(event.id, event.data);
          emit(SetoranDetailSuccess(setoran));
        } catch (e) {
          emit(
            SetoranFailed(
              e.toString(),
            ),
          );
        }
      }
    });
  }
}
