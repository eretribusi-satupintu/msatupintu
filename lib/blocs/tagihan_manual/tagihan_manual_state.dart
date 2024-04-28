part of 'tagihan_manual_bloc.dart';

sealed class TagihanManualState extends Equatable {
  const TagihanManualState();

  @override
  List<Object> get props => [];
}

final class TagihanManualInitial extends TagihanManualState {}

final class TagihanManualLoading extends TagihanManualState {}

final class TagihanManualFailed extends TagihanManualState {
  final String e;
  const TagihanManualFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class TagihanManualDetailSuccess extends TagihanManualState {
  final TagihanManualModel data;
  const TagihanManualDetailSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class TagihanManualSuccess extends TagihanManualState {
  final List<TagihanManualModel> data;
  const TagihanManualSuccess(this.data);

  @override
  List<Object> get props => [data];
}
