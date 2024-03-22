part of 'doku_payment_bloc.dart';

sealed class DokuPaymentState extends Equatable {
  const DokuPaymentState();

  @override
  List<Object> get props => [];
}

final class DokuPaymentInitial extends DokuPaymentState {}

final class DokuPaymentLoading extends DokuPaymentState {}

final class DokuPaymentFailed extends DokuPaymentState {
  final String e;
  const DokuPaymentFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class DokuPaymentSuccess extends DokuPaymentState {
  final DokuVaModel data;

  const DokuPaymentSuccess(this.data);
  @override
  List<Object> get props => [data];
}
