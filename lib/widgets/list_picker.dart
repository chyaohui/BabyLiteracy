import 'package:flutter/material.dart';
import './animation_mixins.dart'; // See my other gist for this

/// A scrollable horizontal list which animates into place on load.
class ListPicker extends StatefulWidget {
  final List<Widget> children;
  final double paddingX, paddingY;
  const ListPicker({
    this.children,
    this.paddingX = 12.0,
    this.paddingY = 12.0,
  });

  @override
  _ListPickerState createState() => _ListPickerState();
}

class _ListPickerState extends State<ListPicker> with StateDelay {
  ScrollController _controller;

  _getController() {
    if (_controller != null) return _controller;
    var cont = ScrollController(initialScrollOffset: 100);

    // This delay is required to allow the controller to bind the scroll view
    delay(0, () => cont.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeOut));

    setState(() => _controller = cont);
    return cont;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
            controller: _getController(),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.paddingX, vertical: widget.paddingY),
              child: Row(children: widget.children),
            )));
  }
}