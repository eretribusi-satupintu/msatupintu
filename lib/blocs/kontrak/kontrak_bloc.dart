import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/kontrak_item_retribusi_model.dart';
import 'package:satupintu_app/services/kontrak_service.dart';

part 'kontrak_event.dart';
part 'kontrak_state.dart';

class KontrakBloc extends Bloc<KontrakEvent, KontrakState> {
  KontrakBloc() : super(KontrakInitial()) {
    on<KontrakEvent>((event, emit) async {
      if (event is KontrakGet) {
        try {
          emit(KontrakLoading());
          final kontrak = await KontrakService().getWajibRetribusiKontrak();
          emit(KontrakListSuccess(kontrak));
        } catch (e) {
          emit(KontrakFailed(e.toString()));
        }
      }

      if (event is KontrakGetDetail) {
        try {
          emit(KontrakLoading());
          final kontrak =
              await KontrakService().getKontrakDetail(event.kontrakId);
          emit(KontrakSuccess(kontrak));
        } catch (e) {
          emit(KontrakFailed(e.toString()));
        }
      }
      if (event is KontrakUpdateStatus) {
        try {
          emit(KontrakLoading());
          final kontrak = await KontrakService()
              .updateKontrakStatus(event.kontrakId, event.status);
          emit(KontrakSuccess(kontrak));
        } catch (e) {
          emit(KontrakFailed(e.toString()));
        }
      }
    });
  }
}
