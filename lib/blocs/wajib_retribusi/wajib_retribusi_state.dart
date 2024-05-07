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

final class WajibRetribusiSuccessDetail extends WajibRetribusiState {
  final WajibRetribusiModel data;

  const WajibRetribusiSuccessDetail(this.data);

  @override
  List<Object> get props => [data];
}

final class WajibRetribusiFailed extends WajibRetribusiState {
  final String e;
  const WajibRetribusiFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class WajibRetribusiPresent extends WajibRetribusiState {
  final int wajibRetribusiId;
  const WajibRetribusiPresent(this.wajibRetribusiId);

  @override
  List<Object> get props => [wajibRetribusiId];
}

final class WajibRetribusiTagihanPresent extends WajibRetribusiState {
  final int tagihanId;
  const WajibRetribusiTagihanPresent(this.tagihanId);

  @override
  List<Object> get props => [tagihanId];
}
