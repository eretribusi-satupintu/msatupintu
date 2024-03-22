import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/pembayaran_model.dart';
import 'package:satupintu_app/services/pembayaran_services.dart';

part 'pembayaran_event.dart';
part 'pembayaran_state.dart';

class PembayaranBloc extends Bloc<PembayaranEvent, PembayaranState> {
  PembayaranBloc() : super(PembayaranInitial()) {
    on<PembayaranEvent>((event, emit) async {
      if (event is PembayaranGet) {
        try {
          emit(PembayaranLoading());
          final pembayaran = await PembayaranService().getPembayaran();
          emit(PembayaranSuccess(pembayaran));
        } catch (e) {
          print(e.toString());
          emit(PembayaranFailed(e.toString()));
        }
      }
    });
  }
}
