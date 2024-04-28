part of 'doku_qris_bloc.dart';

sealed class DokuQrisState extends Equatable {
  const DokuQrisState();

  @override
  List<Object> get props => [];
}

final class DokuQrisInitial extends DokuQrisState {}

final class DokuQrisLoading extends DokuQrisState {}

final class DokuQrisFailed extends DokuQrisState {
  final String e;
  const DokuQrisFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class DokuQrisSuccess extends DokuQrisState {
  final DokuQrisModel data;
  const DokuQrisSuccess(this.data);

  @override
  List<Object> get props => [data];
}
