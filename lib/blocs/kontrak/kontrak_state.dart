part of 'kontrak_bloc.dart';

sealed class KontrakState extends Equatable {
  const KontrakState();

  @override
  List<Object> get props => [];
}

final class KontrakInitial extends KontrakState {}

final class KontrakLoading extends KontrakState {}

final class KontrakFailed extends KontrakState {
  final String e;
  const KontrakFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class KontrakListSuccess extends KontrakState {
  final List<KontrakItemRetribusiModel> data;
  const KontrakListSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class KontrakSuccess extends KontrakState {
  final KontrakItemRetribusiModel kontrak;
  const KontrakSuccess(this.kontrak);

  @override
  List<Object> get props => [kontrak];
}
