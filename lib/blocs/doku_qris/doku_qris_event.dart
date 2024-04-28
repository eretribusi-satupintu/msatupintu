part of 'doku_qris_bloc.dart';

sealed class DokuQrisEvent extends Equatable {
  const DokuQrisEvent();

  @override
  List<Object> get props => [];
}

class DokuQrisGet extends DokuQrisEvent {
  final PaymentQrisModel data;
  final int tagihanId;
  const DokuQrisGet(this.tagihanId, this.data);

  @override
  List<Object> get props => [data];
}
