part of 'pembayaran_bloc.dart';

sealed class PembayaranState extends Equatable {
  const PembayaranState();

  @override
  List<Object> get props => [];
}

final class PembayaranInitial extends PembayaranState {}

final class PembayaranLoading extends PembayaranState {}

final class PembayaranSuccess extends PembayaranState {
  final List<PembayaranModel> data;
  const PembayaranSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class PembayaranFailed extends PembayaranState {
  final String e;
  const PembayaranFailed(this.e);

  @override
  List<Object> get props => [e];
}
