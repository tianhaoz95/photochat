import 'package:flutter/material.dart';

class TokenInputField extends StatefulWidget {
  final TextEditingController ctrl;
  final bool enable;
  const TokenInputField(this.enable, this.ctrl);
  @override
  State<StatefulWidget> createState() {
    return _TokenInputField();
  }
}

class _TokenInputField extends State<TokenInputField> {
  bool visible;
  @override
  void initState() {
    super.initState();
    this.visible = false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enable) {
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Checkbox(
                        value: this.visible,
                        onChanged: (bool nextVal) {
                          setState(() {
                            this.visible = nextVal;
                          });
                        }),
                  ),
                  Text('Show token'),
                ],
              ),
            ),
            Container(
              child: TextField(
                controller: widget.ctrl,
                obscureText: !this.visible,
                decoration: InputDecoration(
                  labelText: 'Secret Token',
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
