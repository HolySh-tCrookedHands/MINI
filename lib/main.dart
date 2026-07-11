import 'package:flutter/material.dart';
import 'package:mini/screens/auth/controlSing.dart';
import 'package:mini/screens/main/index.dart';
import 'package:mini/utils/provider/settings.dart';
import 'package:mini/utils/theme.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsProvider = SettingsProvider();
  await settingsProvider.loadSettings();

  runApp(
    ChangeNotifierProvider(
      create: (_) => settingsProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final bool isSingIn = true;

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini',
      themeMode: settings.theme.mode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: settings.color.color,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: settings.color.color,
          brightness: Brightness.dark,
        ),
      ),
      home: isSingIn == false ? SingUpInScreen() : IndexScreen(),
    );
  }
}
