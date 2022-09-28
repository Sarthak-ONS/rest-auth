import 'package:flutter/material.dart';
import 'package:rest_auth/Screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:rest_auth/Services/auth_api.dart';

Future<void> main() async {
  try {
    await dotenv.load(fileName: "assets/.env");
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  } catch (e) {
    print(e.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => AuthApi()),
        ),
      ],
      child: MaterialApp(
        title: 'Auth App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<AuthApi>(
          builder: ((context, value, _) => const HomeScreen()),
        ),
      ),
    );
  }
}
