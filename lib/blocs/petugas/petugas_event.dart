part of 'petugas_bloc.dart';

sealed class PetugasEvent extends Equatable {
  const PetugasEvent();

  @override
  List<Object> get props => [];
}

class PetugasBillAmountGet extends PetugasEvent {}

class PetugasBillPaid extends PetugasEvent {
  final int tagihanId;

  const PetugasBillPaid(this.tagihanId);

  @override
  List<Object> get props => [tagihanId];
}

class PetugasBillPaidCancel extends PetugasEvent {
  final int tagihanId;

  const PetugasBillPaidCancel(this.tagihanId);

  @override
  List<Object> get props => [tagihanId];
}
