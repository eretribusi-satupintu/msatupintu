import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/retribusi_model.dart';
import 'package:satupintu_app/services/retribusi_services.dart';

part 'retribusi_event.dart';
part 'retribusi_state.dart';

class RetribusiBloc extends Bloc<RetribusiEvent, RetribusiState> {
  RetribusiBloc() : super(RetribusiInitial()) {
    on<RetribusiEvent>((event, emit) async {
      if (event is RetribusiGet) {
        try {
          emit(RetribusiLoading());
          final retribusi = await RetribusiServices().getRetribusi();
          emit(RetribusiSuccess(retribusi));
        } catch (e) {
          emit(RetribusiFailed(e.toString()));
        }
      }

      
    });
  }
}
