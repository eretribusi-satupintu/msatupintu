import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/doku_qris_model.dart';
import 'package:satupintu_app/model/payment_qris_model.dart';
import 'package:satupintu_app/services/payment_services.dart';

part 'doku_qris_event.dart';
part 'doku_qris_state.dart';

class DokuQrisBloc extends Bloc<DokuQrisEvent, DokuQrisState> {
  DokuQrisBloc() : super(DokuQrisInitial()) {
    on<DokuQrisEvent>((event, emit) async {
      if (event is DokuQrisGet) {
        try {
          emit(DokuQrisLoading());
          final qris =
              await PaymentServices().getQris(event.tagihanId, event.data);

          emit(DokuQrisSuccess(qris));
        } catch (e) {
          emit(DokuQrisFailed(e.toString()));
        }
      }
    });
  }
}
