import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/accounts_provider.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Help',
        'subtitle': 'Get support and FAQs',
        'icon': Icons.help_outline,
        'color': Color(0xFF009CA6),
      },
      {
        'title': 'Settings',
        'subtitle': 'App preferences and security',
        'icon': Icons.settings,
        'color': Color(0xFF006C7F),
      },
      {
        'title': 'Cheque Services',
        'subtitle': 'Deposit and manage cheques',
        'icon': Icons.receipt_long,
        'color': Color(0xFF009CA6),
      },
      {
        'title': 'Contact Us',
        'subtitle': 'Get in touch with support',
        'icon': Icons.contact_support,
        'color': Color(0xFF006C7F),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009CA6),
        title: Text('More'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Services & Support',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: menuItems.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: item['color'],
                        child: Icon(
                          item['icon'],
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        item['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        item['subtitle'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                      onTap: () {
                        switch (item['title']) {
                          case 'Help':
                            Navigator.pushNamed(context, '/help');
                            break;
                          case 'Settings':
                            Navigator.pushNamed(context, '/settings');
                            break;
                          case 'Cheque Services':
                            Navigator.pushNamed(context, '/cheque-services');
                            break;
                          case 'Contact Us':
                            Navigator.pushNamed(context, '/contact-us');
                            break;
                        }
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              // Logout Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                  subtitle: Text(
                    'Sign out of your account',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF009CA6),
        unselectedItemColor: Colors.grey,
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/accounts');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/cards');
              break;
            case 3:
              // Already on more
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Accounts'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Cards'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Logout the user
                final userProvider = Provider.of<UserProvider>(context, listen: false);
                final accountsProvider = Provider.of<AccountsProvider>(context, listen: false);
                
                // Clear user data
                if (userProvider.currentUser != null) {
                  accountsProvider.clearUserData(userProvider.currentUser!.name);
                }
                userProvider.logout();
                
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logged out successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
} 