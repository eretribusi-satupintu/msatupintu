part of 'wajib_retribusi_bloc.dart';

sealed class WajibRetribusiState extends Equatable {
  const WajibRetribusiState();

  @override
  List<Object> get props => [];
}

final class WajibRetribusiInitial extends WajibRetribusiState {}

final class WajibRetribusiLoading extends WajibRetribusiState {}

final class WajibRetribusiSuccess extends WajibRetribusiState {
  final List<WajibRetribusiModel> data;

  const WajibRetribusiSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class WajibRetribusiFailed extends WajibRetribusiState {
  final String e;
  const WajibRetribusiFailed(this.e);

  @override
  List<Object> get props => [e];
}
