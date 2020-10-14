import 'package:flutter/material.dart';
import './animation_mixins.dart'; // See my other gist for this

// Ímplicitly animates an int to the given value.
class AnimatedInt extends StatelessWidget {
  final int value;
  final Duration duration; // milliseconds
  final TextStyle style;
  AnimatedInt({
    @required this.value,
    @required this.duration,
    this.style,
  });

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder(
    tween: IntTween(begin: 0, end: value),
    duration: duration,
    curve: Curves.decelerate,
    builder: (context, value, child) =>
        Text(value.toString(), style: style),
  );
}

// Ímplicitly scales a widget with an optional delay.
class AnimatedScale extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Tween<double> tween;
  final Tween<double> tweenInit;
  final Curve curve;
  final Duration delay;

  AnimatedScale({
    @required this.child,
    Duration duration,
    Tween<double> tween,
    Tween<double> tweenInit,
    Curve curve,
    Duration delay,
  })  : this.duration = duration ?? Duration(milliseconds: 500),
        this.tween = tween ?? Tween<double>(begin: 0.0, end: 1.0),
        this.tweenInit = tweenInit ?? Tween<double>(begin: 0.0, end: 0.0),
        this.curve = curve ?? Curves.linear,
        this.delay = delay ?? Duration.zero;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilderDelay(
    child: child,
    tween: tween,
    tweenInit: tweenInit,
    curve: curve,
    delay: delay,
    duration: duration,
    builder: (_, scale, child) =>
        Transform.scale(scale: scale, child: child),
  );
}

/// Mimics the [TweenAnimationBuilder] but with an optional delay.
class TweenAnimationBuilderDelay extends StatefulWidget {
  final Tween<double> tween;
  final Tween<double> tweenInit;
  final Duration duration;
  final ValueWidgetBuilder<double> builder;
  final Duration delay;
  final Curve curve;
  final Widget child;
  final VoidCallback onEnd;

  TweenAnimationBuilderDelay({
    @required this.tween,
    @required this.tweenInit,
    @required this.duration,
    @required this.builder,
    @required this.delay,
    this.curve,
    this.child,
    this.onEnd,
  });

  @override
  createState() => _TweenAnimationBuilderDelayState();
}

// Note: Requires [StateDelay] from my './animation_mixins.dart' gist.
class _TweenAnimationBuilderDelayState extends State<TweenAnimationBuilderDelay> with StateDelay {
  Tween<double> _tween;

  @override
  void initState() {
    super.initState();
    _setTween();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tween.end != widget.tween.end) _setTween();
  }

  _setTween() => setState(() {
    _tween = widget.tween;
    if (widget.tween.end != widget.tweenInit.end && widget.delay != null) {
      _tween = widget.tweenInit;
      setStateDelay(widget.delay.inMilliseconds, () {
        _tween = widget.tween;
      });
    }
  });

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder(
    tween: _tween,
    duration: widget.duration,
    curve: widget.curve,
    builder: widget.builder,
    child: widget.child,
    onEnd: widget.onEnd,
  );
}