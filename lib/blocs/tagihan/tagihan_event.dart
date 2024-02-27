part of 'tagihan_bloc.dart';

sealed class TagihanEvent extends Equatable {
  const TagihanEvent();

  @override
  List<Object> get props => [];
}

class TagihanGet extends TagihanEvent {}
