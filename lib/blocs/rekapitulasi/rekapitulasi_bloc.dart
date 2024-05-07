import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/tagihan_manual_model.dart';
import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/services/tagihan_manual_services.dart';
import 'package:satupintu_app/services/tagihan_services.dart';

part 'rekapitulasi_event.dart';
part 'rekapitulasi_state.dart';

class RekapitulasiBloc extends Bloc<RekapitulasiEvent, RekapitulasiState> {
  RekapitulasiBloc() : super(RekapitulasiInitial()) {
    on<RekapitulasiEvent>((event, emit) async {
      if (event is TagihanKontrakGet) {
        try {
          emit(RekapitulasiLoading());
          final tagihan = await TagihanService().getPetugasAllPaidTagihan();
          int totalNominalTagihan = 0;

          for (var item in tagihan) {
            totalNominalTagihan += item.price!;
          }
          emit(RekapitulasiTagihanKontrakSuccess(
              tagihan, tagihan.length, totalNominalTagihan));
        } catch (e) {
          emit(RekapitulasiFailed(e.toString()));
        }
      }
      if (event is TagihanManualGet) {
        try {
          emit(RekapitulasiLoading());
          final tagihan = await TagihanManualServices().getPaidTagihanManual();
          int totalNominalTagihan = 0;

          for (var item in tagihan) {
            totalNominalTagihan += item.price!;
          }
          emit(RekapitulasiTagihanManualSuccess(
              tagihan, tagihan.length, totalNominalTagihan));
        } catch (e) {
          emit(RekapitulasiFailed(e.toString()));
        }
      }
    });
  }
}
