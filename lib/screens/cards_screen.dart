import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({Key? key}) : super(key: key);
  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  List<Map<String, dynamic>> cards = [];
  Set<String> _showFullDetails = {};
  
  void _initializeCards(String userName) {
    cards = [
      {
        'type': 'Debit Card',
        'number': '**** **** **** 1234',
        'name': userName.toUpperCase(),
        'expiry': '12/25',
        'status': 'Active',
        'color': Color(0xFF009CA6),
        'id': '1',
      },
      {
        'type': 'Credit Card',
        'number': '**** **** **** 5678',
        'name': userName.toUpperCase(),
        'expiry': '08/26',
        'status': 'Active',
        'color': Color(0xFF006C7F),
        'id': '2',
      },
    ];
  }

  void _blockCard(String cardId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Block Card'),
        content: Text('Are you sure you want to block this card? You can unblock it later.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              setState(() {
                final cardIndex = cards.indexWhere((card) => card['id'] == cardId);
                if (cardIndex != -1) {
                  cards[cardIndex]['status'] = 'Blocked';
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Card blocked successfully')),
              );
            },
            child: Text('Block'),
          ),
        ],
      ),
    );
  }

  void _unblockCard(String cardId) {
    setState(() {
      final cardIndex = cards.indexWhere((card) => card['id'] == cardId);
      if (cardIndex != -1) {
        cards[cardIndex]['status'] = 'Active';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Card unblocked successfully')),
    );
  }

  void _showNewCardForm() {
    final _formKey = GlobalKey<FormState>();
    String _cardType = 'Debit Card';
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String userName = userProvider.currentUser?.name ?? 'User';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Request New Card'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _cardType,
                items: ['Debit Card', 'Credit Card']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (val) => _cardType = val!,
                decoration: InputDecoration(
                  labelText: 'Card Type',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: userName,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ],
          ),
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
              if (_formKey.currentState!.validate()) {
                setState(() {
                  cards.add({
                    'type': _cardType,
                    'number': '**** **** **** ${(1000 + cards.length).toString()}',
                    'name': userName.toUpperCase(),
                    'expiry': '${DateTime.now().month.toString().padLeft(2, '0')}/${(DateTime.now().year + 3).toString().substring(2)}',
                    'status': 'Active',
                    'color': _cardType == 'Debit Card' ? Color(0xFF009CA6) : Color(0xFF006C7F),
                    'id': (cards.length + 1).toString(),
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('New card requested successfully')),
                );
              }
            },
            child: Text('Request'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String userName = userProvider.currentUser?.name ?? 'User';
    
    // Initialize cards if empty (only once)
    if (cards.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _initializeCards(userName);
        });
      });
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009CA6),
        title: Text('My Cards'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showNewCardForm,
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
                'Your Cards',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cards.length,
                separatorBuilder: (_, __) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final card = cards[index];
                  final isBlocked = card['status'] == 'Blocked';
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            isBlocked ? Colors.grey : card['color'],
                            isBlocked ? Colors.grey.withOpacity(0.8) : card['color'].withOpacity(0.8)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                card['type'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isBlocked ? Colors.red.withOpacity(0.2) : Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  card['status'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _showFullDetails.contains(card['id']) 
                                    ? '1234 5678 9012 ${card['number'].split(' ').last}'
                                    : card['number'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  _showFullDetails.contains(card['id']) 
                                    ? Icons.visibility_off 
                                    : Icons.visibility,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (_showFullDetails.contains(card['id'])) {
                                      _showFullDetails.remove(card['id']);
                                    } else {
                                      _showFullDetails.add(card['id']);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                          if (_showFullDetails.contains(card['id'])) ...[
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'CVV: 123',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Full Number: 1234 5678 9012 ${card['number'].split(' ').last}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CARD HOLDER',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    card['name'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'EXPIRES',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    card['expiry'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: BorderSide(color: Colors.white),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (isBlocked) {
                                      _unblockCard(card['id']);
                                    } else {
                                      _blockCard(card['id']);
                                    }
                                  },
                                  child: Text(isBlocked ? 'Unblock' : 'Block'),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: BorderSide(color: Colors.white),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('View transactions')),
                                    );
                                  },
                                  child: Text('Transactions'),
                                ),
                              ),
                            ],
                          ),
                        ],
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
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/accounts');
              break;
            case 2:
              // Already on cards
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