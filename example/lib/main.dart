import 'package:flutter/material.dart';
import 'package:onyx_plugin/onyx.dart';

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
        var snackBar = SnackBar(
          content: Text(OnyxCamera.state.resultMessage),
        );
        ScaffoldMessenger.of(appContext).showSnackBar(snackBar);
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
        title: 'Onyx Plugin Demo',
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
