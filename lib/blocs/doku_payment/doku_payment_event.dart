part of 'doku_payment_bloc.dart';

sealed class DokuPaymentEvent extends Equatable {
  const DokuPaymentEvent();

  @override
  List<Object> get props => [];
}

class DokuVaGet extends DokuPaymentEvent {
  final PaymentVaModel data;
  final int tagihanId;
  const DokuVaGet(this.tagihanId, this.data);

  @override
  List<Object> get props => [data];
}
