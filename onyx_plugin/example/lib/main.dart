import 'package:flutter/material.dart';
import 'package:onyx_plugin/onyx.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'settings-screen.dart';
import 'fingerprint-screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BuildContext appContext;

  @override
  void initState() {
    super.initState();
    OnyxCamera.state.addListener(() {
      if (OnyxCamera.state.isError) {
        showTopSnackBar(
          appContext,
          CustomSnackBar.error(
            message: OnyxCamera.state.resultMessage,
          ),
        );
      }
      if (OnyxCamera.state.status == OnyxStatuses.success) {
        Navigator.of(appContext)
            .push(MaterialPageRoute(builder: (context) => FingerprintScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Builder(builder: (context) {
          appContext = context;
          if (OnyxCamera.state.status == OnyxStatuses.success) {
            return FingerprintScreen();
          } else {
            return SettingsScreen();
          }
        }));
  }
}
