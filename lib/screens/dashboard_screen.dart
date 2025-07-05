import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/accounts_provider.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String userName = userProvider.currentUser?.name ?? 'User';
    final accountsProvider = Provider.of<AccountsProvider>(context);
    final accounts = accountsProvider.getAccountsForUser(userName);
    final transactions = accountsProvider.getTransactionsForUser(userName);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009CA6),
        title: Row(
          children: [
            Image.asset('lib/assets/ecobank_logo.png', height: 32),
            SizedBox(width: 8),
            Text('Dashboard'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
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
                'Welcome, $userName',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Account cards
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: accounts.length,
                  separatorBuilder: (_, __) => SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final acc = accounts[index];
                    return Container(
                      width: 220,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF009CA6), Color(0xFF006C7F)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            acc.type + ' Account',
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '₵${acc.balance.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Acct: ${acc.number}',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 24),
              // Quick actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _QuickActionButton(
                    icon: Icons.send,
                    label: 'Transfer',
                    color: Color(0xFF009CA6),
                    onTap: () => Navigator.pushNamed(context, '/transfer'),
                  ),
                  _QuickActionButton(
                    icon: Icons.receipt_long,
                    label: 'Pay Bills',
                    color: Color(0xFF009CA6),
                    onTap: () => Navigator.pushNamed(context, '/bills'),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                separatorBuilder: (_, __) => Divider(),
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  return ListTile(
                    leading: Icon(
                      tx.amount > 0 ? Icons.arrow_downward : Icons.arrow_upward,
                      color: tx.amount > 0 ? Colors.green : Colors.red,
                    ),
                    title: Text(tx.desc),
                    subtitle: Text(tx.date),
                    trailing: Text(
                      (tx.amount > 0 ? '+' : '-') + '₵${tx.amount.abs().toStringAsFixed(2)}',
                      style: TextStyle(
                        color: tx.amount > 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF009CA6),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on dashboard
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/accounts');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/cards');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/more');
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
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
} 