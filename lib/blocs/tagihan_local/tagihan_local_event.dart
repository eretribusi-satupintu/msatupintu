part of 'tagihan_local_bloc.dart';

sealed class TagihanLocalEvent extends Equatable {
  const TagihanLocalEvent();

  @override
  List<Object> get props => [];
}

class TagihanLocalFromServerStore extends TagihanLocalEvent {}

class TagihanLocalGet extends TagihanLocalEvent {
  // final String status;
  // const TagihanLocalGet(this.status);
}

class TagihanLocalStore extends TagihanLocalEvent {}

class TagihanLocalShow extends TagihanLocalEvent {
  final int id;
  const TagihanLocalShow(this.id);
}

class TagihanLocalUpdate extends TagihanLocalEvent {
  final int id;
  const TagihanLocalUpdate(this.id);
}

class TagihanLocalDeleteAll extends TagihanLocalEvent {}

class TagihanLocalDelete extends TagihanLocalEvent {
  final int id;
  const TagihanLocalDelete(this.id);
}
