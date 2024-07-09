  import 'package:flutter/material.dart';

Future<DateTime?> showIDate(BuildContext context, DateTime date) {
    return showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now());
  }

  Future<DateTime?> showEDate(BuildContext context, DateTime date) {
    return showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime.now(),
                              lastDate: DateTime(3000));
  }