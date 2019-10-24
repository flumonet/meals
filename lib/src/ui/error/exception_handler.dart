import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:meals/src/ui/error/error.dart';

class ExceptionHandler {
  final BuildContext _context;

  ExceptionHandler._internal(this._context);

  ExceptionHandler.of(BuildContext context) : this._internal(context);

  Error handle(Exception exception) {
    if (exception is SocketException) {
      return Error(
        title: "Brak internetu",
        message: "Sprawdz swoje połączenie z internetem i sprobuj ponownie",
      );
    } else if (exception is TimeoutException) {
      return Error(
        title: "Wystapił błąd",
        message:
            "Komunikcja z serwerem trwala dłużej niż powinna. Spróbuj ponownie za 30 sekund",
      );
    } else {
      return Error(
        title: "Wystapił błąd",
        message:
            "Błąs po stronie naszego servera. Spróbuj ponownie za 30 sekund.",
      );
    }
  }
}
