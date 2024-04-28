part of 'item_retribusi_sewa_bloc.dart';

sealed class ItemRetribusiSewaState extends Equatable {
  const ItemRetribusiSewaState();

  @override
  List<Object> get props => [];
}

final class ItemRetribusiSewaInitial extends ItemRetribusiSewaState {}

final class ItemRetribusiSewaLoading extends ItemRetribusiSewaState {}

final class ItemRetribusiSewaSuccess extends ItemRetribusiSewaState {
  final List<KontrakItemRetribusiModel> data;
  const ItemRetribusiSewaSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class ItemRetribusiSewaFailed extends ItemRetribusiSewaState {
  final String e;

  const ItemRetribusiSewaFailed(this.e);

  @override
  List<Object> get props => [e];
}
