import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/model/tagihan_update_model.dart';
import 'package:satupintu_app/model/transaksi_petugas_model.dart';
import 'package:satupintu_app/services/petugas_service.dart';
import 'package:satupintu_app/services/subwilayah_services.dart';
import 'package:satupintu_app/services/transaksi_petugas_services.dart';

part 'petugas_event.dart';
part 'petugas_state.dart';

class PetugasBloc extends Bloc<PetugasEvent, PetugasState> {
  PetugasBloc() : super(PetugasInitial()) {
    on<PetugasEvent>((event, emit) async {
      if (event is PetugasBillAmountGet) {
        try {
          emit(PetugasLoading());
          final billAmount = await PetugasService().getBillAmount();
          emit(PetugasBillAmountSuccess(billAmount));
        } catch (e) {
          emit(PetugasFailed(e.toString()));
        }
      }
      if (event is PetugasBillPaid) {
        try {
          emit(PetugasLoading());
          final billPay =
              await TransaksiPetugas().petugasPaidTagihan(event.tagihanId);
          emit(PetugasSuccess(billPay));
        } catch (e) {
          emit(PetugasFailed(e.toString()));
        }
      }
      if (event is PetugasBillPaidCancel) {
        try {
          emit(PetugasLoading());
          final billPay = await TransaksiPetugas()
              .petugasPaidTagihanCancel(event.tagihanId);
          emit(PetugasSuccess(billPay));
        } catch (e) {
          emit(PetugasFailed(e.toString()));
        }
      }
    });
  }
}
