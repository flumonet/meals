import 'package:meta/meta.dart';

class Error {
  final String title;
  final String message;
  final String code;

  Error({@required this.title, @required this.message, this.code});
}
