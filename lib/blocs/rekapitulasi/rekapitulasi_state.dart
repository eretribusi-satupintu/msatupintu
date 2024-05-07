part of 'rekapitulasi_bloc.dart';

sealed class RekapitulasiState extends Equatable {
  const RekapitulasiState();

  @override
  List<Object> get props => [];
}

final class RekapitulasiInitial extends RekapitulasiState {}

final class RekapitulasiLoading extends RekapitulasiState {}

final class RekapitulasiTagihanKontrakSuccess extends RekapitulasiState {
  final List<TagihanModel> data;
  final int jumlahTagihan;
  final int totalNominalTagihan;
  const RekapitulasiTagihanKontrakSuccess(
      this.data, this.jumlahTagihan, this.totalNominalTagihan);

  @override
  List<Object> get props => [data, jumlahTagihan, totalNominalTagihan];
}

final class RekapitulasiTagihanManualSuccess extends RekapitulasiState {
  final List<TagihanManualModel> data;
  final int jumlahTagihan;
  final int totalNominalTagihan;
  const RekapitulasiTagihanManualSuccess(
      this.data, this.jumlahTagihan, this.totalNominalTagihan);

  @override
  List<Object> get props => [data, jumlahTagihan, totalNominalTagihan];
}

final class RekapitulasiFailed extends RekapitulasiState {
  final String e;
  const RekapitulasiFailed(this.e);

  @override
  List<Object> get props => [e];
}
