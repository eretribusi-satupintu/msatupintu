import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/subwilayah_model.dart';
import 'package:satupintu_app/services/subwilayah_services.dart';

part 'subwilayah_event.dart';
part 'subwilayah_state.dart';

class SubwilayahBloc extends Bloc<SubwilayahEvent, SubwilayahState> {
  SubwilayahBloc() : super(SubwilayahInitial()) {
    on<SubwilayahEvent>((event, emit) async {
      if (event is GetPetugasSubWilayah) {
        try {
          emit(SubwilayahLoading());
          final subwilayah = await SubWilayahService().getSubWilayah();
          emit(SubwilayahSuccess(subwilayah));
        } catch (e) {
          SubwilayahFailed(e.toString());
        }
      }
      if (event is SelectPetugasSubWilayah) {
        try {
          emit(SubwilayahLoading());
          await SubWilayahService().storeSubwilayahToLocalStorage(event.data);
        } catch (e) {
          emit(SubwilayahFailed(e.toString()));
        }
      }
      if (event is GetSelectedPetugasSubWilayah) {
        try {
          emit(SubwilayahLoading());
          final subwilayah =
              await SubWilayahService().getSubwilayahFromLocalStorage();
          emit(SelectedSubwilayahSuccess(subwilayah));
        } catch (e) {
          emit(SubwilayahFailed(e.toString()));
        }
      }
    });
  }
}
