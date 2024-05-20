import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/payment_instruction_model.dart';
import 'package:satupintu_app/services/payment_instruction_services.dart';

part 'payment_instruction_event.dart';
part 'payment_instruction_state.dart';

class PaymentInstructionBloc
    extends Bloc<PaymentInstructionEvent, PaymentInstructionState> {
  PaymentInstructionBloc() : super(PaymentInstructionInitial()) {
    on<PaymentInstructionEvent>((event, emit) async {
      if (event is PaymentInstructionGet) {
        try {
          emit(PaymentInstructionLoading());
          final paymentInstruction = await PaymentInstructionServices()
              .getPaymentInstruction(event.url);
          print(paymentInstruction);
          emit(PaymentInstructionSuccess(paymentInstruction));
        } catch (e) {
          print(e);
          emit(PaymentInstructionFailed(e.toString()));
        }
      }
    });
  }
}
