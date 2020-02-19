import 'package:flutter/material.dart';
import 'slider_bloc.dart';

export 'slider_bloc.dart';

class SliderBlocProvider extends InheritedWidget {
  const SliderBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  SliderBloc get bloc => SliderBloc();

  @override
  bool updateShouldNotify(_) => true;

  static SliderBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SliderBlocProvider>();
  }
}