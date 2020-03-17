import 'package:flutter/material.dart';
import 'package:photochatapp/services/i18n/i18n.dart';

class TokenInputField extends StatefulWidget {
  final TextEditingController ctrl;
  final bool enable;
  final String keyVal;
  const TokenInputField(this.enable, this.ctrl, {this.keyVal});
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
                  Text(AppLocalizations.of(context).showTokenCheckboxText),
                ],
              ),
            ),
            Container(
              child: TextField(
                key: Key(widget.keyVal),
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
