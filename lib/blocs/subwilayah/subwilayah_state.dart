part of 'subwilayah_bloc.dart';

sealed class SubwilayahState extends Equatable {
  const SubwilayahState();

  @override
  List<Object> get props => [];
}

final class SubwilayahInitial extends SubwilayahState {}

final class SubwilayahLoading extends SubwilayahState {}

final class SubwilayahFailed extends SubwilayahState {
  final String e;
  const SubwilayahFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class SelectedSubwilayahSuccess extends SubwilayahState {
  final SubWilayahModel data;

  const SelectedSubwilayahSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class SubwilayahSuccess extends SubwilayahState {
  final List<SubWilayahModel> data;

  const SubwilayahSuccess(this.data);

  @override
  List<Object> get props => [data];
}
