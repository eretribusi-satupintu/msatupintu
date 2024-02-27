import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/services/tagihan_services.dart';

part 'tagihan_event.dart';
part 'tagihan_state.dart';

class TagihanBloc extends Bloc<TagihanEvent, TagihanState> {
  TagihanBloc() : super(TagihanInitial()) {
    on<TagihanEvent>((event, emit) async {
      if (event is TagihanGet) {
        try {
          emit(TagihanLoading());
          final tagihan = await TagihanService().getTagihan();
          // print(jsonEncode({"tagihan": tagihan}));
          emit(TagihanSuccess(tagihan));
        } catch (e) {
          emit(TagihanFailed(e.toString()));
        }
      }
    });
  }
}
