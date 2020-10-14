import 'dart:async';
import 'package:flutter/material.dart';

/// A mixin to perform context dependent function when the widget loads.
mixin FirstLoad<T extends StatefulWidget> on State<T> {
  bool _hasLoaded = false;
  bool get isFirstLoad => !_hasLoaded;
  /// Calls the given callback on the first load only.
  /// This should NOT be called in [initState] as the UI will not have rendered it.
  /// This should only be used when an initialised [context] is required.
  onFirstLoad(Function callback) {
    if (isFirstLoad)
      setState(() {
        _hasLoaded = true;
        callback();
      });
  }
}

/// A mixin which provides common timer functionality and util methods.
mixin StateDelay<T extends StatefulWidget> on State<T> {
  List<Timer> _timers = [];

  /// Calls the given callback after the given amount of time in milliseconds
  delay(int delay, void Function() callback) =>
      _timers.add(Timer(Duration(milliseconds: delay), callback));

  /// Calls the callback within [setState] after the given amount of time in milliseconds
  setStateDelay(int delay, void Function() callback) =>
      this.delay(delay, () => setState(callback));

  setTimer(Timer timer) => _timers.add(timer);

  _cancelTimers() => _timers.forEach((t) => t.cancel());

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }
}