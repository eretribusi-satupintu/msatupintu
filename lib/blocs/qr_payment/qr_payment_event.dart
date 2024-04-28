part of 'qr_payment_bloc.dart';

sealed class QrPaymentEvent extends Equatable {
  const QrPaymentEvent();

  @override
  List<Object> get props => [];
}

class QrPatmentTagihanGet extends QrPaymentEvent {
  final String code;
  const QrPatmentTagihanGet(this.code);
}
