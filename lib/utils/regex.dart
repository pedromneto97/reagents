RegExp get unNumberRegex => RegExp(
      r'\d{2,4}',
    );

RegExp get riskNumberRegex => RegExp(
      r'(^$|x\d{2,3})|\d{2,4}',
      caseSensitive: false,
    );
