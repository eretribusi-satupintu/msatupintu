import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/doku_va_model.dart';
import 'package:satupintu_app/model/payment_va_model.dart';
import 'package:satupintu_app/services/payment_services.dart';

part 'doku_payment_event.dart';
part 'doku_payment_state.dart';

class DokuPaymentBloc extends Bloc<DokuPaymentEvent, DokuPaymentState> {
  DokuPaymentBloc() : super(DokuPaymentInitial()) {
    on<DokuPaymentEvent>((event, emit) async {
      if (event is DokuVaGet) {
        try {
          emit(DokuPaymentLoading());
          final payment = await PaymentServices().getVaPayment(event.data);
          emit(DokuPaymentSuccess(payment));
        } catch (e) {
          emit(DokuPaymentFailed(e.toString()));
        }
      }
    });
  }
}
