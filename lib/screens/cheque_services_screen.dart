import 'package:flutter/material.dart';

class ChequeServicesScreen extends StatefulWidget {
  const ChequeServicesScreen({Key? key}) : super(key: key);
  @override
  _ChequeServicesScreenState createState() => _ChequeServicesScreenState();
}

class _ChequeServicesScreenState extends State<ChequeServicesScreen> {
  final List<Map<String, dynamic>> _chequeHistory = [
    {
      'chequeNumber': 'CHK001234',
      'amount': 5000.00,
      'status': 'Cleared',
      'date': '2024-06-01',
      'type': 'Deposit',
      'color': Colors.green,
    },
    {
      'chequeNumber': 'CHK001235',
      'amount': 2500.00,
      'status': 'Pending',
      'date': '2024-05-30',
      'type': 'Deposit',
      'color': Colors.orange,
    },
    {
      'chequeNumber': 'CHK001236',
      'amount': 10000.00,
      'status': 'Stopped',
      'date': '2024-05-28',
      'type': 'Issued',
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009CA6),
        title: Text('Cheque Services'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Actions
              Text(
                'Quick Actions',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      'Deposit Cheque',
                      Icons.upload_file,
                      Color(0xFF009CA6),
                      () => _showDepositChequeDialog(context),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildActionCard(
                      'Stop Cheque',
                      Icons.block,
                      Color(0xFF006C7F),
                      () => _showStopChequeDialog(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      'Cheque Status',
                      Icons.info_outline,
                      Color(0xFF009CA6),
                      () => _showChequeStatusDialog(context),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildActionCard(
                      'Request Cheque Book',
                      Icons.book,
                      Color(0xFF006C7F),
                      () => _showRequestChequeBookDialog(context),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 32),
              
              // Cheque History
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cheque History',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
              
              // Recent Cheques
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _chequeHistory.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final cheque = _chequeHistory[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: cheque['color'],
                        child: Icon(
                          cheque['type'] == 'Deposit' ? Icons.upload : Icons.download,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Cheque ${cheque['chequeNumber']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Amount: ₵${cheque['amount'].toStringAsFixed(2)}'),
                          Text('Date: ${cheque['date']}'),
                        ],
                      ),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: cheque['color'].withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          cheque['status'],
                          style: TextStyle(
                            color: cheque['color'],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      onTap: () => _showChequeDetailsDialog(context, cheque),
                    ),
                  );
                },
              ),
              
              SizedBox(height: 32),
              
              // Information Section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cheque Information',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      _buildInfoRow('Processing Time', '2-3 business days'),
                      _buildInfoRow('Deposit Limit', '₵100,000 per cheque'),
                      _buildInfoRow('Stop Cheque Fee', '₵50 per cheque'),
                      _buildInfoRow('Cheque Book Fee', '₵25 per book'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 24,
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showDepositChequeDialog(BuildContext context) {
    final chequeNumberController = TextEditingController();
    final amountController = TextEditingController();
    final accountController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Deposit Cheque'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: chequeNumberController,
              decoration: InputDecoration(
                labelText: 'Cheque Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
                prefixText: '₵',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: accountController,
              decoration: InputDecoration(
                labelText: 'Account Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF009CA6),
              ),
              onPressed: () {
                // Handle image upload
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Upload cheque image')),
                );
              },
              icon: Icon(Icons.camera_alt, color: Colors.white),
              label: Text('Take Photo', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF009CA6)),
            onPressed: () {
              // Validate inputs
              if (chequeNumberController.text.isEmpty || 
                  amountController.text.isEmpty || 
                  accountController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please fill in all fields'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              
              // Parse amount
              double? amount;
              try {
                amount = double.parse(amountController.text);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter a valid amount'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              
              // Add new cheque to history
              final newCheque = {
                'chequeNumber': chequeNumberController.text,
                'amount': amount,
                'status': 'Pending',
                'date': DateTime.now().toString().split(' ')[0], // Today's date
                'type': 'Deposit',
                'color': Colors.orange,
              };
              
              setState(() {
                _chequeHistory.insert(0, newCheque); // Add to beginning of list
              });
              
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Cheque deposit submitted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Deposit'),
          ),
        ],
      ),
    );
  }

  void _showStopChequeDialog(BuildContext context) {
    final chequeNumberController = TextEditingController();
    final reasonController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Stop Cheque'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: chequeNumberController,
              decoration: InputDecoration(
                labelText: 'Cheque Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                labelText: 'Reason',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // Validate inputs
              if (chequeNumberController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter cheque number'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              
              // Find and update cheque status
              bool chequeFound = false;
              for (int i = 0; i < _chequeHistory.length; i++) {
                if (_chequeHistory[i]['chequeNumber'] == chequeNumberController.text) {
                  setState(() {
                    _chequeHistory[i]['status'] = 'Stopped';
                    _chequeHistory[i]['color'] = Colors.red;
                  });
                  chequeFound = true;
                  break;
                }
              }
              
              Navigator.pop(context);
              if (chequeFound) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Cheque stopped successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Cheque not found in history'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: Text('Stop Cheque'),
          ),
        ],
      ),
    );
  }

  void _showChequeStatusDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Check Cheque Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Cheque Number',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF009CA6)),
            onPressed: () {
              Navigator.pop(context);
              _showChequeStatusResult(context);
            },
            child: Text('Check'),
          ),
        ],
      ),
    );
  }

  void _showChequeStatusResult(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cheque Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cheque Number: CHK001234'),
            Text('Status: Cleared'),
            Text('Amount: ₵5,000.00'),
            Text('Cleared Date: 2024-06-01'),
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
  }

  void _showRequestChequeBookDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Request Cheque Book'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Account Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Number of Leaves',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Delivery Address',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF009CA6)),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Cheque book request submitted')),
              );
            },
            child: Text('Request'),
          ),
        ],
      ),
    );
  }

  void _showChequeDetailsDialog(BuildContext context, Map<String, dynamic> cheque) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cheque Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cheque Number: ${cheque['chequeNumber']}'),
            Text('Amount: ₵${cheque['amount'].toStringAsFixed(2)}'),
            Text('Status: ${cheque['status']}'),
            Text('Date: ${cheque['date']}'),
            Text('Type: ${cheque['type']}'),
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
  }

  void _showAllChequesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('All Cheques'),
        content: Container(
          height: 300,
          child: ListView.builder(
            itemCount: _chequeHistory.length,
            itemBuilder: (context, index) {
              final cheque = _chequeHistory[index];
              return ListTile(
                title: Text('Cheque ${cheque['chequeNumber']}'),
                subtitle: Text('₵${cheque['amount'].toStringAsFixed(2)} - ${cheque['date']}'),
                trailing: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: cheque['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    cheque['status'],
                    style: TextStyle(
                      color: cheque['color'],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
} 