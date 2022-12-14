import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/introduction.dart';
import 'package:flutter_application_1/nutification%20services/nutificationservices.dart';
import 'package:flutter_application_1/theme%20privider/theme.dart';
import 'package:provider/provider.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => Themeprovider(),
        builder: (context, _) {
          final themeprovider = Provider.of<Themeprovider>(context);
          return MaterialApp(
              title: 'Flutter Demo',
              themeMode: themeprovider.themeMode,
              theme: MyTheme.lighttheme,
              darkTheme: MyTheme.darktheme,
              // theme: ThemeData(
              //   primarySwatch: Colors.blue,
              // ),
              debugShowCheckedModeBanner: false,
              home: const introduction());
        },
      );
}
