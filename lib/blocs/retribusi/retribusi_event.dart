part of 'retribusi_bloc.dart';

sealed class RetribusiEvent extends Equatable {
  const RetribusiEvent();

  @override
  List<Object> get props => [];
}

class RetribusiGet extends RetribusiEvent {}
