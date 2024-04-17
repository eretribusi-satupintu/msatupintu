part of 'kontrak_bloc.dart';

sealed class KontrakEvent extends Equatable {
  const KontrakEvent();

  @override
  List<Object> get props => [];
}

class KontrakGet extends KontrakEvent {}

class KontrakGetDetail extends KontrakEvent {
  final int kontrakId;
  const KontrakGetDetail(this.kontrakId);
}

class KontrakUpdateStatus extends KontrakEvent {
  final int kontrakId;
  final String status;
  const KontrakUpdateStatus(this.kontrakId, this.status);
}
