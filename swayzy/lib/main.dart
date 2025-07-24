import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swayzy/screens/home/home.dart';

import 'constants/app_button_styles.dart';
import 'constants/app_colors.dart';
import 'constants/app_routes.dart';
import 'constants/app_text_styles.dart';
import 'constants/private_data.dart';
import 'firebase_config.dart';
import 'l10n/app_localizations.dart';
import 'screens/chat/chat.dart';
import 'screens/creation/creation.dart';
import 'screens/profile/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: './dotenv');
  await Firebase.initializeApp(options: firebaseConfig);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Supabase.initialize(
    url: PrivateData.supabaseId,
    anonKey: PrivateData.supabaseApi,
  );

  final prefs = await SharedPreferences.getInstance();
  final language = prefs.getString('language') ?? "en";

  runApp(MyApp(locale: Locale(language),));
}

void Function(String)? changeLanguageCallback;

class MyApp extends StatefulWidget {
  final Locale locale;
  const MyApp({super.key, required this.locale});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  void _changeLanguage(String languageCode) async {
    setState(() {
      _locale = Locale(languageCode);
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }

  @override
  void initState() {
    super.initState();
    _locale = widget.locale;
    changeLanguageCallback = _changeLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swayzy',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          titleLarge: AppTextStyles.title,
          titleMedium: AppTextStyles.title,
          titleSmall: AppTextStyles.title,
          bodyLarge: AppTextStyles.body,
          bodyMedium: AppTextStyles.body,
          bodySmall: AppTextStyles.body,
          displayLarge: AppTextStyles.body,
          displayMedium: AppTextStyles.body,
          displaySmall: AppTextStyles.body,
          headlineLarge: AppTextStyles.title,
          headlineMedium: AppTextStyles.title,
          headlineSmall: AppTextStyles.title,
          labelLarge: AppTextStyles.body,
          labelMedium: AppTextStyles.body,
          labelSmall: AppTextStyles.body,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.highlight,
          surface: AppColors.primaryBackground,
          brightness: Brightness.light,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.highlight),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.highlight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.highlight),
          ),
          labelStyle: AppTextStyles.form,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(AppColors.text),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppButtonStyles.secondary,
        ),
      ),
      initialRoute: '/auth',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FirebaseUILocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('uk')],
      locale: _locale,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const Creation(),
    const Chat(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String navBarItemText = localizations.bottomNavBarItem;

    FlutterNativeSplash.remove();

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore_outlined, size: 40),
            label: navBarItemText,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_circle_outline_rounded, size: 40),
            label: navBarItemText,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat_outlined, size: 40),
            label: navBarItemText,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle_outlined, size: 40),
            label: navBarItemText,
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        backgroundColor: AppColors.secondaryBackground,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.highlight,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
