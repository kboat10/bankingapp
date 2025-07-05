import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/accounts_provider.dart';
import '../providers/user_provider.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({Key? key}) : super(key: key);
  @override
  _BillsScreenState createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String? _selectedPayee;
  String? _selectedAccount;
  String _amount = '';
  String _dueDate = '';
  bool _schedulePayment = false;
  String _scheduledDate = '';

  // Add a list to store scheduled payments
  List<Map<String, dynamic>> _scheduledPayments = [];

  final List<Map<String, dynamic>> _billCategories = [
    {
      'name': 'Utilities',
      'icon': Icons.electric_bolt,
      'payees': ['ECG', 'Ghana Water', 'DStv', 'GOtv', 'DSTV Premium'],
    },
    {
      'name': 'Credit Cards',
      'icon': Icons.credit_card,
      'payees': ['Visa Card', 'MasterCard', 'American Express'],
    },
    {
      'name': 'Loans',
      'icon': Icons.account_balance,
      'payees': ['Personal Loan', 'Home Loan', 'Car Loan', 'Business Loan'],
    },
    {
      'name': 'Insurance',
      'icon': Icons.security,
      'payees': ['Life Insurance', 'Health Insurance', 'Car Insurance', 'Home Insurance'],
    },
  ];

  List<String> get _payees {
    if (_selectedCategory == null) return [];
    final category = _billCategories.firstWhere((cat) => cat['name'] == _selectedCategory);
    return List<String>.from(category['payees']);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String userName = userProvider.currentUser?.name ?? 'User';
    final accountsProvider = Provider.of<AccountsProvider>(context);
    final accounts = accountsProvider.getAccountsForUser(userName);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009CA6),
        title: Text('Pay Bills'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
                  'Bill Payment',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                
                // Bill Category Selection
                Text(
                  'Bill Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: _billCategories
                      .map((category) => DropdownMenuItem<String>(
                            value: category['name'] as String,
                            child: Row(
                              children: [
                                Icon(category['icon'] as IconData),
                                SizedBox(width: 8),
                                Text(category['name'] as String),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedCategory = val;
                      _selectedPayee = null; // Reset payee when category changes
                    });
                  },
                  validator: (val) => val == null ? 'Select a bill category' : null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                SizedBox(height: 20),

                // Payee Selection
                if (_selectedCategory != null) ...[
                  Text(
                    'Payee',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedPayee,
                    items: _payees
                        .map((payee) => DropdownMenuItem(
                              value: payee,
                              child: Text(payee),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedPayee = val),
                    validator: (val) => val == null ? 'Select a payee' : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                  SizedBox(height: 20),
                ],

                // Account Selection
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

                // Amount Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                    prefixText: '₵',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Enter amount';
                    final amount = double.tryParse(val);
                    if (amount == null || amount <= 0) return 'Enter a valid amount';
                    if (_selectedAccount != null && amount > accounts[int.parse(_selectedAccount!)].balance) {
                      return 'Insufficient funds';
                    }
                    return null;
                  },
                  onSaved: (val) => _amount = val ?? '',
                ),
                SizedBox(height: 20),

                // Due Date Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Due Date (Optional)',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        _dueDate = '${date.day}/${date.month}/${date.year}';
                      });
                    }
                  },
                  readOnly: true,
                  controller: TextEditingController(text: _dueDate),
                ),
                SizedBox(height: 20),

                // Schedule Payment Option
                CheckboxListTile(
                  title: Text('Schedule Payment'),
                  subtitle: Text('Pay on a future date'),
                  value: _schedulePayment,
                  onChanged: (value) {
                    setState(() {
                      _schedulePayment = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                if (_schedulePayment) ...[
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Payment Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(Duration(days: 1)),
                        firstDate: DateTime.now().add(Duration(days: 1)),
                        lastDate: DateTime.now().add(Duration(days: 90)),
                      );
                      if (date != null) {
                        setState(() {
                          _scheduledDate = '${date.day}/${date.month}/${date.year}';
                        });
                      }
                    },
                    readOnly: true,
                    controller: TextEditingController(text: _scheduledDate),
                    validator: (val) => _schedulePayment && (val == null || val.isEmpty) ? 'Select payment date' : null,
                  ),
                  SizedBox(height: 20),
                ],

                // Pay Button
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
                        _showPaymentConfirmation(context);
                      }
                    },
                    child: Text(
                      _schedulePayment ? 'Schedule Payment' : 'Pay Bill',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPaymentConfirmation(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String userName = userProvider.currentUser?.name ?? 'User';
    final accountsProvider = Provider.of<AccountsProvider>(context, listen: false);
    final accounts = accountsProvider.getAccountsForUser(userName);
    final fromAccountIndex = int.parse(_selectedAccount!);
    final amount = double.parse(_amount);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_schedulePayment ? 'Schedule Payment' : 'Confirm Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: $_selectedCategory'),
            Text('Payee: $_selectedPayee'),
            Text('From: ${accounts[fromAccountIndex].type} - ${accounts[fromAccountIndex].number}'),
            Text('Amount: ₵$_amount'),
            if (_dueDate.isNotEmpty) Text('Due Date: $_dueDate'),
            if (_schedulePayment) Text('Payment Date: $_scheduledDate'),
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
              if (_schedulePayment) {
                // Store scheduled payment, do not deduct now
                _scheduledPayments.add({
                  'category': _selectedCategory,
                  'payee': _selectedPayee,
                  'fromAccountIndex': fromAccountIndex,
                  'amount': amount,
                  'dueDate': _dueDate,
                  'scheduledDate': _scheduledDate,
                });
              } else {
                // Immediate payment, deduct now
                accountsProvider.transferFunds(
                  userName: userName,
                  fromAccountIndex: fromAccountIndex,
                  recipient: _selectedPayee!,
                  amount: amount,
                  description: 'Bill Payment - $_selectedCategory',
                );
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_schedulePayment ? 'Payment scheduled successfully!' : 'Payment successful!'),
                ),
              );
              // Reset form
              _formKey.currentState!.reset();
              setState(() {
                _selectedCategory = null;
                _selectedPayee = null;
                _selectedAccount = null;
                _dueDate = '';
                _schedulePayment = false;
                _scheduledDate = '';
              });
            },
            child: Text(_schedulePayment ? 'Schedule' : 'Pay'),
          ),
        ],
      ),
    );
  }
} 