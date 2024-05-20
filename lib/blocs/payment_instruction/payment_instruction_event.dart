part of 'payment_instruction_bloc.dart';

sealed class PaymentInstructionEvent extends Equatable {
  const PaymentInstructionEvent();

  @override
  List<Object> get props => [];
}

class PaymentInstructionGet extends PaymentInstructionEvent {
  final String url;
  const PaymentInstructionGet(this.url);
}
