import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'main_menu_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koperasi Undiksha',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/main': (context) => const MainMenuScreen(),
      },
    );
  }
}

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/profile':
        final args = settings.arguments as ProfileArguments;
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(
            balance: args.balance,
            onReceive: args.onReceive,
            accountName: args.accountName,
            accountImageUrl: args.accountImageUrl,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}

class ProfileArguments {
  final double balance;
  final Function(double) onReceive;
  final String accountName;
  final String accountImageUrl;

  ProfileArguments({
    required this.balance,
    required this.onReceive,
    required this.accountName,
    required this.accountImageUrl,
  });
}