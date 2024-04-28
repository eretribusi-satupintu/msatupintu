import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/kontrak_item_retribusi_model.dart';
import 'package:satupintu_app/services/item_retribusi_service_test.dart';

part 'item_retribusi_sewa_event.dart';
part 'item_retribusi_sewa_state.dart';

class ItemRetribusiSewaBloc
    extends Bloc<ItemRetribusiSewaEvent, ItemRetribusiSewaState> {
  ItemRetribusiSewaBloc() : super(ItemRetribusiSewaInitial()) {
    on<ItemRetribusiSewaEvent>((event, emit) async {
      if (event is ItemRetribusiSewaGet) {
        try {
          emit(ItemRetribusiSewaLoading());
          final itemRetribusi = await ItemRetribusiService()
              .getItemRetribusiSewa(event.retribusiId);
          emit(ItemRetribusiSewaSuccess(itemRetribusi));
        } catch (e) {
          emit(
            ItemRetribusiSewaFailed(
              e.toString(),
            ),
          );
        }
      }

      if (event is KontrakWajibRetribusiGet) {
        try {
          emit(ItemRetribusiSewaLoading());
          final res = await ItemRetribusiService()
              .getKontrakWajibRetribusi(event.wajibRetribusiId);
          emit(ItemRetribusiSewaSuccess(res));
        } catch (e) {
          emit(ItemRetribusiSewaFailed(e.toString()));
        }
      }
    });
  }
}
