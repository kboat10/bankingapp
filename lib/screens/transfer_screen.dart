import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/accounts_provider.dart';
import '../providers/user_provider.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);
  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedAccount;
  String _recipient = '';
  String _amount = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String userName = userProvider.currentUser?.name ?? 'User';
    final accountsProvider = Provider.of<AccountsProvider>(context);
    final accounts = accountsProvider.getAccountsForUser(userName);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009CA6),
        title: Text('Transfer Funds'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Source Account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedAccount,
                  items: accounts
                      .asMap()
                      .entries
                      .map((entry) => DropdownMenuItem(
                            value: entry.key.toString(),
                            child: Text('${entry.value.type} - ${entry.value.number}'),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedAccount = val),
                  validator: (val) => val == null ? 'Select an account' : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Recipient Account Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (val) => val == null || val.isEmpty ? 'Enter recipient account number' : null,
                  onSaved: (val) => _recipient = val ?? '',
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Enter amount';
                    final amount = double.tryParse(val);
                    if (amount == null || amount <= 0) return 'Enter a valid amount';
                    if (_selectedAccount != null && amount > accounts[int.parse(_selectedAccount!)].balance) return 'Insufficient funds';
                    return null;
                  },
                  onSaved: (val) => _amount = val ?? '',
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description (optional)',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (val) => _description = val ?? '',
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF009CA6),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final fromAccountIndex = int.parse(_selectedAccount!);
                        final amount = double.parse(_amount);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Confirm Transfer'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('From: ${accounts[fromAccountIndex].type} - ${accounts[fromAccountIndex].number}'),
                                Text('To: $_recipient'),
                                Text('Amount: ₵$_amount'),
                                if (_description.isNotEmpty)
                                  Text('Description: $_description'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF009CA6),
                                ),
                                onPressed: () {
                                  accountsProvider.transferFunds(
                                    userName: userName,
                                    fromAccountIndex: fromAccountIndex,
                                    recipient: _recipient,
                                    amount: amount,
                                    description: _description,
                                  );
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Transfer Successful!')),
                                  );
                                  _formKey.currentState!.reset();
                                  setState(() {
                                    _selectedAccount = null;
                                  });
                                },
                                child: Text('Confirm'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text('Transfer', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 