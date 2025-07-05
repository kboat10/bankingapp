import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {


  final List<Map<String, dynamic>> _helpCategories = [
    {
      'title': 'Getting Started',
      'icon': Icons.play_circle_outline,
      'color': Color(0xFF009CA6),
      'topics': [
        {
          'question': 'How do I log in to my account?',
          'answer': 'Enter your full name and password on the login screen. If you\'ve forgotten your password, use the "Forgot password?" link.',
        },
        {
          'question': 'How do I change my password?',
          'answer': 'Go to Settings > Security > Change Password. You\'ll need your current password to set a new one.',
        },
        {
          'question': 'How do I enable biometric login?',
          'answer': 'Go to Settings > Security > Biometric Login and follow the setup instructions for fingerprint or face recognition.',
        },
      ],
    },
    {
      'title': 'Transfers & Payments',
      'icon': Icons.send,
      'color': Color(0xFF006C7F),
      'topics': [
        {
          'question': 'How do I transfer money?',
          'answer': 'Go to Transfer Funds, select your source account, enter recipient details and amount, then confirm the transfer.',
        },
        {
          'question': 'What are the transfer limits?',
          'answer': 'Daily limit: ₵50,000, Monthly limit: ₵500,000. Contact us to increase your limits.',
        },
        {
          'question': 'How do I pay bills?',
          'answer': 'Go to Pay Bills, select bill category and payee, enter amount and confirm payment.',
        },
      ],
    },
    {
      'title': 'Cards & Security',
      'icon': Icons.credit_card,
      'color': Color(0xFF009CA6),
      'topics': [
        {
          'question': 'How do I block my card?',
          'answer': 'Go to Cards > Select your card > Tap Block. You can unblock it anytime.',
        },
        {
          'question': 'What should I do if my card is lost?',
          'answer': 'Immediately block your card in the app and contact our 24/7 support line.',
        },
        {
          'question': 'How do I set spending limits?',
          'answer': 'Go to Cards > Select card > Settings > Spending Limits to set daily/monthly limits.',
        },
      ],
    },
    {
      'title': 'Account Management',
      'icon': Icons.account_balance_wallet,
      'color': Color(0xFF006C7F),
      'topics': [
        {
          'question': 'How do I view my transaction history?',
          'answer': 'Go to Accounts > Select account > Transactions to view your transaction history.',
        },
        {
          'question': 'How do I download statements?',
          'answer': 'Go to Accounts > Select account > Details > Download Statement.',
        },
        {
          'question': 'How do I update my contact information?',
          'answer': 'Go to Settings > Profile > Edit Information to update your details.',
        },
      ],
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009CA6),
        title: Text('Help & Support'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Quick Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF009CA6),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      _showContactDialog(context);
                    },
                    icon: Icon(Icons.phone, color: Colors.white),
                    label: Text('Call Support', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF006C7F),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      _showLiveChatDialog(context);
                    },
                    icon: Icon(Icons.chat, color: Colors.white),
                    label: Text('Live Chat', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16),
          
          // Help Categories
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: _helpCategories.length,
              itemBuilder: (context, index) {
                final category = _helpCategories[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            backgroundColor: category['color'],
                            child: Icon(category['icon'], color: Colors.white),
                          ),
                          title: Text(
                            category['title'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          children: category['topics'].map<Widget>((topic) {
                            return ListTile(
                              title: Text(
                                topic['question'],
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text(topic['answer']),
                              ),
                              onTap: () {
                                _showTopicDetail(context, topic);
                              },
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showTopicDetail(BuildContext context, Map<String, dynamic> topic) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Help Topic'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic['question'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(topic['answer']),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF009CA6),
            ),
            onPressed: () {
              Navigator.pop(context);
              _showContactDialog(context);
            },
            child: Text('Still Need Help?'),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Contact Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Call us 24/7:'),
            Text('+233 XX XXX XXXX', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Or email us:'),
            Text('support@ecobank.com', style: TextStyle(fontWeight: FontWeight.bold)),
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

  void _showLiveChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Live Chat'),
        content: Text('Our live chat support is available 24/7. A representative will assist you shortly.'),
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