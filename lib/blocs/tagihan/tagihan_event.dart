part of 'tagihan_bloc.dart';

sealed class TagihanEvent extends Equatable {
  const TagihanEvent();

  @override
  List<Object> get props => [];
}

class TagihanNewestGet extends TagihanEvent {}

class TagihanRetribusiGet extends TagihanEvent {
  final int itemRetribusiId;
  const TagihanRetribusiGet(this.itemRetribusiId);
}
