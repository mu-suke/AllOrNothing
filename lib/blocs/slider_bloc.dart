import 'dart:async';
import 'dart:math' show Random;

import 'package:all_or_nothing_slider/mySliderClass.dart';

class SliderBloc {
  final _startController = StreamController<void>();
  final _calcController = StreamController<int>();
  final _outputController = StreamController<String>();
  final _btnController = StreamController<bool>();
  final _outputSliderController = StreamController<MySlider>();

  // 入力用sinkのGetter
  StreamSink<void> get start => _startController.sink;

  // sliderの値を入れるGetter
  StreamSink<List<MySlider>> get slider => _outputSliderController.sink;


  // 出力用streamのGetter
  Stream<MySlider> get onAdd => _outputSliderController.stream;
  Stream<bool> get onToggle => _btnController.stream;

  static const _repeat = 6;
  int _sum;
  Timer _timer;

  SliderBloc() {
    // スタートボタンが押されるのを待つ
    _startController.stream.listen((MySlider slider) => _start);

    // 秒数が通知されるのを待つ
    _calcController.stream.listen((count) => _calc(count));

    // ボタンの表示を指示する
    _btnController.sink.add(true);
  }

  void _start(MySlider _slider) {
    slider.add(_slider);
  }

  void _calc(int count) {
    if (count < _repeat + 1) {
      final num = Random().nextInt(99) + 1;
      _outputController.sink.add('$num');
      _sum += num;
    } else {
      _timer.cancel();
      _outputController.sink.add('答えは$_sum');
      _btnController.sink.add(true);
    }
  }

  void dispose() {
    _startController.close();
    _calcController.close();
    _outputController.close();
    _btnController.close();
    _outputSliderController.close();
  }
}