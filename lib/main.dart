import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/Fetures/Content/Presentarion/ContentCubit.dart';
import 'package:my_app/Fetures/Users/Presentation/UserCubit/Cubit.dart';
import 'package:my_app/core/servece/GetIt.dart';
import 'package:my_app/core/themes/themes.dart';
import 'package:my_app/generated/l10n.dart';
import 'package:my_app/view/Homepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ==== Supabase Init ====
  await Supabase.initialize(
    url: 'https://oavhwmafeddhugmfccvr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9hdmh3bWFmZWRkaHVnbWZjY3ZyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIwNDkwMDgsImV4cCI6MjA4NzYyNTAwOH0.ePgHplG14ZYso_L6Nh9gMDL5ZtM2ziXrMflmN4jsEYQ',
  );

  // ==== Setup GetIt ====
  setup(); // سجل كل الـ dependencies

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<userCubit>(create: (_) => sl<userCubit>()),
        BlocProvider<ContentCubit>(create: (_) => sl<ContentCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

// ========================== App Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('ar'),
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainWrapper(),
    );
  }
}

// ========================== Wrapper Widget للفحص
class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  bool isOnline = true;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final online = results.isNotEmpty && results.first != ConnectivityResult.none;
      if (mounted && online != isOnline) {
        setState(() {
          isOnline = online;
        });
      }
    });
  }

  // ==== Check connectivity at start ====
  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (mounted) {
        setState(() {
          isOnline = result != ConnectivityResult.none;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isOnline = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isOnline) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 80, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                "لا يوجد اتصال بالإنترنت",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Themes.mainColor),
                onPressed: _initConnectivity,
                child: const Text("إعادة المحاولة"),
              ),
            ],
          ),
        ),
      );
    }

    // الإنترنت متاح، اعرض الصفحة الرئيسية
    return const Homepage();
  }
}