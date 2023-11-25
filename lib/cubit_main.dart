import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'drtStreamClass.dart';
import 'eputable_main.dart';

class mainCubit extends Cubit<AssignRackState>
{
  mainCubit()
      : super( const AssignRackState(
    contnt: 1,


  ));

getData(cont)
{
print(cont);

/*
  CounterBloc().counterStream.listen((int counter) {
*/
    emit(state.copyWith(contnt:cont));


  /*});*/


}

}
