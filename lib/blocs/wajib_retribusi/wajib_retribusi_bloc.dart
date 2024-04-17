import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/wajib_retribusi_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
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
          final wajibRetribusi =
              await WajibRetribusiService().getWajibRetribusi(event.petugasId);
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
          final wajibRetribusi = await WajibRetribusiService()
              .getWajibRetribusi(int.parse(petugasId));

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
            emit(const WajibRetribusiFailed('Waji Retribusi tidak terdaftar'));
          }
        } catch (e) {
          emit(WajibRetribusiFailed(e.toString()));
        }
      }
    });
  }
}