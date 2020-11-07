library magic_button;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MagicButton<T extends ButtonMagic> extends StreamBuilder<T> {
  MagicButton(
      {Key key,
      T initialData,
      @required Stream<T> stream,
      @required Function action,
      String title,
      TextStyle enable,
      TextStyle disable})
      : super(
            key: key,
            initialData: initialData,
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot<T> snap) {
              return MagicButtonState(
                  title, snap.data, enable, disable, action);
            });
}

class MagicButtonState extends StatelessWidget {
  final String title;
  final ButtonMagic magic;
  final TextStyle inEnable;
  final TextStyle inDisable;
  final Function action;
  MagicButtonState(
      this.title, this.magic, this.inEnable, this.inDisable, this.action);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: magic.enableState() ? action : null,
        child: SizedBox(
          height: 80,
          child: font(title, magic, inEnable, inDisable),
        ));
  }

  Widget font(String title, ButtonMagic magic, TextStyle inEnable,
      TextStyle inDisable) {
    if (magic.isActiviting) {
      return Ink(
        padding: EdgeInsets.zero,
        decoration:
            magic.enableState() ? _decorationEnable() : _decorationDisable(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AlwaysAnimationIndictor(),
            Text(
              title,
              style: magic.enableState() ? inEnable : inDisable,
            ),
          ],
        ),
      );
    } else {
      return Ink(
        padding: EdgeInsets.zero,
        decoration:
            magic.enableState() ? _decorationEnable() : _decorationDisable(),
        child: Center(
            child: Text(
          title,
          style: magic.enableState() ? inEnable : inDisable,
        )),
      );
    }
  }

  ///normal状态按钮样式
  Decoration _decorationEnable() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(colors: [
          Color.fromARGB(1000, 25, 213, 174),
          Color.fromARGB(1000, 0, 191, 164),
        ]));
  }

  ///disable 状态按钮样式
  Decoration _decorationDisable() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(colors: [
          Color.fromARGB(50, 25, 213, 174),
          Color.fromARGB(50, 0, 191, 164),
        ]));
  }
}

class _AlwaysAnimationIndictor extends CupertinoActivityIndicator {
  _AlwaysAnimationIndictor() : super(animating: true);
}

///按钮效果
abstract class ButtonMagic {
  var isEnable = false;

  ///是否可以点击
  var isActiviting = false;

  ///是否需要阻塞交互线程
  bool enableState() {
    return isActiviting ? false : isEnable;
  }
}
