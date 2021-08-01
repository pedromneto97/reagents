import 'package:flutter/material.dart';

import '../../../theme/colors.dart' show black, primary;

class DontShowAgainCheckbox extends StatefulWidget {
  final ValueChanged<bool> onChange;

  const DontShowAgainCheckbox({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  _DontShowAgainCheckboxState createState() => _DontShowAgainCheckboxState();
}

class _DontShowAgainCheckboxState extends State<DontShowAgainCheckbox> {
  bool dontShowAgain = false;

  void onChangeValue(bool? value) {
    setState(() {
      dontShowAgain = value ?? false;
    });
    widget.onChange(dontShowAgain);
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: dontShowAgain,
      dense: true,
      onChanged: onChangeValue,
      activeColor: primary,
      checkColor: black,
      title: Text(
        'Não exibir novamente',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
}
