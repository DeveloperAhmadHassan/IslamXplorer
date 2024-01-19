import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_error_widget.dart';
import 'package:islamxplorer_flutter/widgets/utils/error.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    ErrorWidgetClass(details);
  };
  runApp(MyApp());
}
// class ErrorWidgetClass extends StatelessWidget {
//   final FlutterErrorDetails errorDetails;
//   ErrorWidgetClass(this.errorDetails);
//   @override
//   Widget build(BuildContext context) {
//     return CustomErrorWidget(
//       errorMessage: errorDetails.exceptionAsString(),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Error Widget Example',
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Error Widget Example'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Throw Error'),
          onPressed: () {
            CustomErrorWidget(errorMessage: "Thrown Error");
          },
        ),
      ),
    );
  }
}