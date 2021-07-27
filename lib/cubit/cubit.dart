import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator/cubit/states.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcCubit extends Cubit<CalcStates>{
  CalcCubit() : super(CalcInitialState());

  static CalcCubit get(context) => BlocProvider.of(context);
  String result = "";
  void equal(String equation, String expression) {
  }
}