import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/src/ui/error/exception_handler.dart';

class ErrorScreen extends StatelessWidget {
  final Exception exception;
  final VoidCallback onRetry;

  const ErrorScreen({Key key, @required this.exception, this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildErrorContent(context),
        ],
      ),
    );
  }

  Widget _buildErrorContent(BuildContext context) {
    final error = ExceptionHandler.of(context).handle(exception);

    return Container(
      padding: EdgeInsets.only(
        left: 18,
        right: 18,
        bottom: 36,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            error.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.display1,
          ),
          SizedBox(height: 16),
          Text(
            error.message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body1,
          ),
          SizedBox(height: 128),
          _buildRetryButtonWhenNeeded(context),
        ],
      ),
    );
  }

  Widget _buildRetryButtonWhenNeeded(BuildContext context) {
    return (onRetry != null)
        ? SafeArea(
            child: CupertinoButton(
              color: Theme.of(context).accentColor,
              onPressed: onRetry,
              child: Text(
                "spróbuj ponownie",
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.white),
              ),
            ),
          )
        : SizedBox(height: 44);
  }
}
