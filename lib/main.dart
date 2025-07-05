import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'providers/accounts_provider.dart';
// Import screens (to be created)
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/transfer_screen.dart';
import 'screens/bills_screen.dart';
import 'screens/accounts_screen.dart';
import 'screens/more_screen.dart';
import 'screens/cards_screen.dart';
import 'screens/help_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/cheque_services_screen.dart';
import 'screens/contact_us_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AccountsProvider()),
      ],
      child: BankingApp(),
    ),
  );
}

class BankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banking App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/transfer': (context) => TransferScreen(),
        '/bills': (context) => BillsScreen(),
        '/accounts': (context) => AccountsScreen(),
        '/cards': (context) => CardsScreen(),
        '/more': (context) => MoreScreen(),
        '/help': (context) => HelpScreen(),
        '/settings': (context) => SettingsScreen(),
        '/cheque-services': (context) => ChequeServicesScreen(),
        '/contact-us': (context) => ContactUsScreen(),
      },
    );
  }
}
