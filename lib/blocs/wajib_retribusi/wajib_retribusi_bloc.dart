import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/wajib_retribusi_model.dart';
import 'package:satupintu_app/services/wajib_retribusi_services.dart';

part 'wajib_retribusi_event.dart';
part 'wajib_retribusi_state.dart';

class WajibRetribusiBloc
    extends Bloc<WajibRetribusiEvent, WajibRetribusiState> {
  WajibRetribusiBloc() : super(WajibRetribusiInitial()) {
    on<WajibRetribusiEvent>((event, emit) async {
      if (event is WajibRetribusiGet) {
        try {
          emit(WajibRetribusiLoading());
          final wajibRetribusi = await WajibRetribusiService()
              .getWajibRetribusi(event.petugasId, event.subWilayahId);
          emit(WajibRetribusiSuccess(wajibRetribusi));
        } catch (e) {
          emit(WajibRetribusiFailed(e.toString()));
        }
      }
    });
  }
}
