part of 'item_retribusi_bloc.dart';

sealed class ItemRetribusiState extends Equatable {
  const ItemRetribusiState();

  @override
  List<Object> get props => [];
}

final class ItemRetribusiInitial extends ItemRetribusiState {}

final class ItemRetribusiLoading extends ItemRetribusiState {}

final class ItemRetribusiFailed extends ItemRetribusiState {
  final String e;
  const ItemRetribusiFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class ItemRetribusiSuccess extends ItemRetribusiState {
  final List<ItemRetribusiModel> data;
  const ItemRetribusiSuccess(this.data);

  @override
  List<Object> get props => [data];
}
