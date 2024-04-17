part of 'pembayaran_bloc.dart';

sealed class PembayaranEvent extends Equatable {
  const PembayaranEvent();

  @override
  List<Object> get props => [];
}

class PembayaranGet extends PembayaranEvent {
  final String status;
  const PembayaranGet(this.status);
}
