import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/item_retribusi_model.dart';
import 'package:satupintu_app/services/item_retribusi_services.dart';

part 'item_retribusi_event.dart';
part 'item_retribusi_state.dart';

class ItemRetribusiBloc extends Bloc<ItemRetribusiEvent, ItemRetribusiState> {
  ItemRetribusiBloc() : super(ItemRetribusiInitial()) {
    on<ItemRetribusiEvent>((event, emit) async {
      if (event is ItemRetribusiGet) {
        try {
          emit(ItemRetribusiLoading());
          final itemRetribusi =
              await ItemRetribusiServices().getItemRetribusi();

          emit(ItemRetribusiSuccess(itemRetribusi));
        } catch (e) {
          emit(ItemRetribusiFailed(e.toString()));
        }
      }
    });
  }
}
