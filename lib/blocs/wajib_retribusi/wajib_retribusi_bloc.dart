import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/model/wajib_retribusi_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:satupintu_app/services/tagihan_services.dart';
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
          late List<WajibRetribusiModel> wajibRetribusi;
          if (event.name == null) {
            wajibRetribusi = await WajibRetribusiService().getWajibRetribusi();
          } else {
            wajibRetribusi = await WajibRetribusiService()
                .getWajibRetribusiByWrName(event.name!);
          }
          emit(WajibRetribusiSuccess(wajibRetribusi));
        } catch (e) {
          emit(WajibRetribusiFailed(e.toString()));
        }
      }
      if (event is WajibRetribusiGetDetail) {
        try {
          emit(WajibRetribusiLoading());
          final wajibRetribusi = await WajibRetribusiService()
              .getWajibRetribusiDetail(event.wajibRetribusiId);
          emit(WajibRetribusiSuccessDetail(wajibRetribusi));
        } catch (e) {
          emit(WajibRetribusiFailed(e.toString()));
        }
      }
      if (event is WajibRetribusiGetDetailFromScan) {
        try {
          emit(WajibRetribusiLoading());
          final petugasId = await AuthService().getRoleId();
          final wajibRetribusi =
              await WajibRetribusiService().getWajibRetribusi();

          bool isPresent = false;
          int? wajibRetribusiId;

          for (var item in wajibRetribusi) {
            if (item.nik == event.nik) {
              isPresent = true;
              wajibRetribusiId = item.id;
            }
          }

          if (isPresent) {
            emit(WajibRetribusiPresent(wajibRetribusiId!));
          } else {
            emit(const WajibRetribusiFailed('Wajib Retribusi tidak terdaftar'));
          }
        } catch (e) {
          emit(WajibRetribusiFailed(e.toString()));
        }
      }

      if (event is WajibRetribusiGetDetailTagihanFromScan) {
        try {
          emit(WajibRetribusiLoading());
          final tagihan =
              await TagihanService().getTagihanDetail(event.tagihanId);

          if (tagihan.status == 'NEW') {
            emit(WajibRetribusiTagihanPresent(tagihan.id!));
          } else {
            emit(const WajibRetribusiFailed('Tagihan tidak tersedia'));
          }
        } catch (e) {
          emit(WajibRetribusiFailed(e.toString()));
        }
      }

      if (event is ScanUndefined) {
        emit(const WajibRetribusiFailed('Tidak dapat mengenali kode'));
      }
    });
  }
}
