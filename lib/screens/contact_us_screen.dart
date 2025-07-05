import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedCategory = 'General Inquiry';

  final List<String> _categories = [
    'General Inquiry',
    'Account Issues',
    'Card Problems',
    'Transfer Issues',
    'Bill Payment',
    'Technical Support',
    'Complaint',
    'Feedback',
  ];

  final List<Map<String, dynamic>> _branches = [
    {
      'name': 'Accra Main Branch',
      'address': '123 High Street, Accra',
      'phone': '+233 30 266 0000',
      'hours': 'Mon-Fri: 8:00 AM - 4:00 PM',
      'distance': '0.5 km',
    },
    {
      'name': 'Kumasi Branch',
      'address': '456 Central Avenue, Kumasi',
      'phone': '+233 30 266 0000',
      'hours': 'Mon-Fri: 8:00 AM - 4:00 PM',
      'distance': '250 km',
    },
    {
      'name': 'Tema Branch',
      'address': '789 Industrial Road, Tema',
      'phone': '+233 30 266 0000',
      'hours': 'Mon-Fri: 8:00 AM - 4:00 PM',
      'distance': '25 km',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009CA6),
        title: Text('Contact Us'),
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
              // Quick Contact Methods
              Text(
                'Get in Touch',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              
              // Contact Cards
              Row(
                children: [
                  Expanded(
                    child: _buildContactCard(
                      'Call Us',
                      Icons.phone,
                      '+233 30 266 0000',
                      '24/7 Support',
                      Color(0xFF009CA6),
                      () => _showCallDialog(context),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildContactCard(
                      'Live Chat',
                      Icons.chat,
                      'Start Chat',
                      'Available Now',
                      Color(0xFF006C7F),
                      () => _showLiveChatDialog(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildContactCard(
                      'Email',
                      Icons.email,
                      'support@ecobank.com',
                      'Response in 24h',
                      Color(0xFF009CA6),
                      () => _showEmailDialog(context),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildContactCard(
                      'WhatsApp',
                      Icons.message,
                      '+233 30 266 0000',
                      'Quick Response',
                      Colors.green,
                      () => _showWhatsAppDialog(context),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 32),
              
              // Contact Form
              Text(
                'Send us a Message',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                          ),
                          items: _categories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            labelText: 'Message',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your message';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF009CA6),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: _submitForm,
                            child: Text(
                              'Send Message',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 32),
              
              // Branch Locations
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Branch Locations',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => _showAllBranchesDialog(context),
                    child: Text('View All'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              
              // Nearby Branches
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _branches.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final branch = _branches[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFF009CA6),
                        child: Icon(Icons.location_on, color: Colors.white),
                      ),
                      title: Text(
                        branch['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(branch['address']),
                          Text(branch['hours']),
                          Text('${branch['distance']} away'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.phone, color: Color(0xFF009CA6)),
                        onPressed: () => _callBranch(branch['phone']),
                      ),
                      onTap: () => _showBranchDetailsDialog(context, branch),
                    ),
                  );
                },
              ),
              
              SizedBox(height: 32),
              
              // Support Hours
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Support Hours',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      _buildSupportHourRow('Phone Support', '24/7'),
                      _buildSupportHourRow('Live Chat', '6:00 AM - 10:00 PM'),
                      _buildSupportHourRow('Email Support', '24/7 (Response in 24h)'),
                      _buildSupportHourRow('WhatsApp', '7:00 AM - 9:00 PM'),
                      _buildSupportHourRow('Branch Services', 'Mon-Fri: 8:00 AM - 4:00 PM'),
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

  Widget _buildContactCard(String title, IconData icon, String subtitle, String description, Color color, VoidCallback onTap) {
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
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 10, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportHourRow(String service, String hours) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(service),
          Text(hours, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Message sent successfully! We\'ll get back to you soon.'),
          backgroundColor: Colors.green,
        ),
      );
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _messageController.clear();
      setState(() {
        _selectedCategory = 'General Inquiry';
      });
    }
  }

  void _showCallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('24/7 Customer Support:'),
            Text('+233 30 266 0000', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Card Support:'),
            Text('+233 30 266 0000', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Emergency:'),
            Text('+233 30 266 0000', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
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
        content: Text('Connecting you to a customer service representative...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Email Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('General Support:'),
            Text('support@ecobank.com', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Card Support:'),
            Text('cards@ecobank.com', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Technical Support:'),
            Text('tech@ecobank.com', style: TextStyle(fontWeight: FontWeight.bold)),
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

  void _showWhatsAppDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('WhatsApp Support'),
        content: Text('Send us a message on WhatsApp: +233 30 266 0000'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showBranchDetailsDialog(BuildContext context, Map<String, dynamic> branch) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(branch['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: ${branch['address']}'),
            Text('Phone: ${branch['phone']}'),
            Text('Hours: ${branch['hours']}'),
            Text('Distance: ${branch['distance']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF009CA6)),
            onPressed: () {
              Navigator.pop(context);
              _callBranch(branch['phone']);
            },
            child: Text('Call'),
          ),
        ],
      ),
    );
  }

  void _showAllBranchesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('All Branches'),
        content: Container(
          height: 300,
          child: ListView.builder(
            itemCount: _branches.length,
            itemBuilder: (context, index) {
              final branch = _branches[index];
              return ListTile(
                title: Text(branch['name']),
                subtitle: Text(branch['address']),
                trailing: IconButton(
                  icon: Icon(Icons.phone, color: Color(0xFF009CA6)),
                  onPressed: () => _callBranch(branch['phone']),
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

  void _callBranch(String phone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling $phone...')),
    );
  }
} 