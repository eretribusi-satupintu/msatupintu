part of 'retribusi_bloc.dart';

sealed class RetribusiState extends Equatable {
  const RetribusiState();

  @override
  List<Object> get props => [];
}

final class RetribusiInitial extends RetribusiState {}

final class RetribusiLoading extends RetribusiState {}

final class RetribusiSuccess extends RetribusiState {
  final List<RetribusiModel> data;
  const RetribusiSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class RetribusiFailed extends RetribusiState {
  final String e;
  const RetribusiFailed(this.e);

  @override
  List<Object> get props => [e];
}
