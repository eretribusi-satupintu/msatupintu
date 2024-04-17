part of 'setoran_bloc.dart';

sealed class SetoranState extends Equatable {
  const SetoranState();

  @override
  List<Object> get props => [];
}

final class SetoranInitial extends SetoranState {}

final class SetoranLoading extends SetoranState {}

final class SetoranSuccess extends SetoranState {
  final List<SetoranModel> data;
  const SetoranSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class SetoranDetailSuccess extends SetoranState {
  final SetoranModel data;
  const SetoranDetailSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class SetoranFailed extends SetoranState {
  final String e;
  const SetoranFailed(this.e);

  @override
  List<Object> get props => [e];
}
