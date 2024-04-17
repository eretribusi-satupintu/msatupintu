part of 'petugas_bloc.dart';

sealed class PetugasState extends Equatable {
  const PetugasState();

  @override
  List<Object> get props => [];
}

final class PetugasInitial extends PetugasState {}

final class PetugasLoading extends PetugasState {}

final class PetugasFailed extends PetugasState {
  final String e;
  const PetugasFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class PetugasSuccess extends PetugasState {
  final TagihanModel data;
  const PetugasSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class PetugasBillAmountSuccess extends PetugasState {
  final int amount;
  const PetugasBillAmountSuccess(this.amount);

  @override
  List<Object> get props => [amount];
}
