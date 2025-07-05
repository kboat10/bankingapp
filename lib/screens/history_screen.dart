import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/accounts_provider.dart';
import '../providers/user_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String userName = userProvider.currentUser?.name ?? 'User';
    final accountsProvider = Provider.of<AccountsProvider>(context);
    final transactions = accountsProvider.getTransactionsForUser(userName);

    List filteredTransactions = transactions;
    if (_selectedFilter == 'Credit') {
      filteredTransactions = transactions.where((tx) => tx.amount > 0).toList();
    } else if (_selectedFilter == 'Debit') {
      filteredTransactions = transactions.where((tx) => tx.amount < 0).toList();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009CA6),
        title: Text('Transaction History'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Filter: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: ['All', 'Credit', 'Debit']
                      .map((filter) => DropdownMenuItem(
                            value: filter,
                            child: Text(filter),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredTransactions.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No transactions found',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredTransactions.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (context, index) {
                      final tx = filteredTransactions[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: tx.amount > 0 ? Colors.green : Colors.red,
                          child: Icon(
                            tx.amount > 0 ? Icons.arrow_downward : Icons.arrow_upward,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          tx.desc,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tx.date),
                            Text('To: ${tx.recipient}'),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              (tx.amount > 0 ? '+' : '-') + '₵${tx.amount.abs().toStringAsFixed(2)}',
                              style: TextStyle(
                                color: tx.amount > 0 ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              tx.amount > 0 ? 'Credit' : 'Debit',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Transaction Details'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Description: ${tx.desc}'),
                                  Text('Amount: ${tx.amount > 0 ? '+' : '-'}₵${tx.amount.abs().toStringAsFixed(2)}'),
                                  Text('Date: ${tx.date}'),
                                  Text('Recipient: ${tx.recipient}'),
                                  Text('Type: ${tx.amount > 0 ? 'Credit' : 'Debit'}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Close'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
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
              // Already on history
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Accounts'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Cards'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
} 