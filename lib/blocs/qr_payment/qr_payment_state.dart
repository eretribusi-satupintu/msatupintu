part of 'qr_payment_bloc.dart';

sealed class QrPaymentState extends Equatable {
  const QrPaymentState();

  @override
  List<Object> get props => [];
}

final class QrPaymentInitial extends QrPaymentState {}

final class QrPaymentLoading extends QrPaymentState {}

final class QrPaymentFailed extends QrPaymentState {
  final String e;
  const QrPaymentFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class QrPaymentSuccess extends QrPaymentState {
  final String category;
  final int id;
  const QrPaymentSuccess(this.id, this.category);

  @override
  List<Object> get props => [id];
}
