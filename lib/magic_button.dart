library magic_button;

import 'dart:async';

import 'package:flutter/material.dart';

class MagicButton extends StreamBuilder {
  MagicButton(
      {Key key,
      bool initialData,
      @required Stream<bool> stream,
      @required Function action,
      String title,
      TextStyle enable,
      TextStyle disable})
      : super(
            key: key,
            initialData: initialData,
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
              return MagicButtonState(
                  title, snap.data, enable, disable, action);
            });
}

class MagicButtonState extends StatelessWidget {
  final String title;
  final bool enabled;
  final TextStyle inEnable;
  final TextStyle inDisable;
  final Function action;
  MagicButtonState(
      this.title, this.enabled, this.inEnable, this.inDisable, this.action);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: enabled == true ? action : null,
        child: SizedBox(
          height: 80,
          child: f(title, enabled == true, inEnable, inDisable),
        ));
  }

  Widget f(
      String title, bool enabled, TextStyle inEnable, TextStyle inDisable) {
    return Ink(
      padding: EdgeInsets.zero,
      decoration: enabled ? _decoration() : null,
      child: Center(
          child: Text(
        title,
        style: enabled == true ? inEnable : inDisable,
      )),
    );
  }

  Decoration _decoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(colors: [
          Color.fromARGB(1000, 25, 213, 174),
          Color.fromARGB(1000, 0, 191, 164),
        ]));
  }
}
