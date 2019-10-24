import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Center(child: PlatformCircularProgressIndicator());
}
