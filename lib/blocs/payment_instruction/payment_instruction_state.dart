part of 'payment_instruction_bloc.dart';

sealed class PaymentInstructionState extends Equatable {
  const PaymentInstructionState();

  @override
  List<Object> get props => [];
}

final class PaymentInstructionInitial extends PaymentInstructionState {}

final class PaymentInstructionLoading extends PaymentInstructionState {}

final class PaymentInstructionSuccess extends PaymentInstructionState {
  final List<PaymentInstructionModel> data;
  const PaymentInstructionSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class PaymentInstructionFailed extends PaymentInstructionState {
  final String e;
  const PaymentInstructionFailed(this.e);

  @override
  List<Object> get props => [e];
}
