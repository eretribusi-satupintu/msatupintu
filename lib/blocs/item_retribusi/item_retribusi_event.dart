part of 'item_retribusi_bloc.dart';

sealed class ItemRetribusiEvent extends Equatable {
  const ItemRetribusiEvent();

  @override
  List<Object> get props => [];
}

class ItemRetribusiGet extends ItemRetribusiEvent {}
