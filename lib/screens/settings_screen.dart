import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _biometricLogin = true;
  bool _twoFactorAuth = true;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'GHS (₵)';
  bool _locationServices = false;
  bool _analytics = true;

  final List<String> _languages = ['English', 'French', 'Arabic', 'Swahili'];
  final List<String> _currencies = ['GHS (₵)', 'USD (\$)', 'EUR (€)', 'GBP (£)'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF009CA6),
        title: Text('Settings'),
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
              // Notifications Section
              _buildSectionHeader('Notifications', Icons.notifications),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text('Push Notifications'),
                      subtitle: Text('Receive app notifications'),
                      value: _pushNotifications,
                      onChanged: (value) => setState(() => _pushNotifications = value),
                      secondary: Icon(Icons.notifications_active, color: Color(0xFF009CA6)),
                    ),
                    Divider(height: 1),
                    SwitchListTile(
                      title: Text('Email Notifications'),
                      subtitle: Text('Receive email alerts'),
                      value: _emailNotifications,
                      onChanged: (value) => setState(() => _emailNotifications = value),
                      secondary: Icon(Icons.email, color: Color(0xFF009CA6)),
                    ),
                    Divider(height: 1),
                    SwitchListTile(
                      title: Text('SMS Notifications'),
                      subtitle: Text('Receive SMS alerts'),
                      value: _smsNotifications,
                      onChanged: (value) => setState(() => _smsNotifications = value),
                      secondary: Icon(Icons.sms, color: Color(0xFF009CA6)),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Security Section
              _buildSectionHeader('Security', Icons.security),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text('Biometric Login'),
                      subtitle: Text('Use fingerprint or face ID'),
                      value: _biometricLogin,
                      onChanged: (value) => setState(() => _biometricLogin = value),
                      secondary: Icon(Icons.fingerprint, color: Color(0xFF009CA6)),
                    ),
                    Divider(height: 1),
                    SwitchListTile(
                      title: Text('Two-Factor Authentication'),
                      subtitle: Text('Extra security for your account'),
                      value: _twoFactorAuth,
                      onChanged: (value) => setState(() => _twoFactorAuth = value),
                      secondary: Icon(Icons.verified_user, color: Color(0xFF009CA6)),
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('Change Password'),
                      subtitle: Text('Update your login password'),
                      leading: Icon(Icons.lock, color: Color(0xFF009CA6)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _showChangePasswordDialog(context),
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('Login History'),
                      subtitle: Text('View recent login activity'),
                      leading: Icon(Icons.history, color: Color(0xFF009CA6)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _showLoginHistoryDialog(context),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Preferences Section
              _buildSectionHeader('Preferences', Icons.tune),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Language'),
                      subtitle: Text(_selectedLanguage),
                      leading: Icon(Icons.language, color: Color(0xFF009CA6)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _showLanguageDialog(context),
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('Currency'),
                      subtitle: Text(_selectedCurrency),
                      leading: Icon(Icons.attach_money, color: Color(0xFF009CA6)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _showCurrencyDialog(context),
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('Theme'),
                      subtitle: Text('Light'),
                      leading: Icon(Icons.palette, color: Color(0xFF009CA6)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _showThemeDialog(context),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Privacy Section
              _buildSectionHeader('Privacy', Icons.privacy_tip),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text('Location Services'),
                      subtitle: Text('Allow location access'),
                      value: _locationServices,
                      onChanged: (value) => setState(() => _locationServices = value),
                      secondary: Icon(Icons.location_on, color: Color(0xFF009CA6)),
                    ),
                    Divider(height: 1),
                    SwitchListTile(
                      title: Text('Analytics'),
                      subtitle: Text('Help improve the app'),
                      value: _analytics,
                      onChanged: (value) => setState(() => _analytics = value),
                      secondary: Icon(Icons.analytics, color: Color(0xFF009CA6)),
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('Privacy Policy'),
                      subtitle: Text('Read our privacy policy'),
                      leading: Icon(Icons.description, color: Color(0xFF009CA6)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _showPrivacyPolicyDialog(context),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Account Section
              _buildSectionHeader('Account', Icons.person),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Profile'),
                      subtitle: Text('Edit your profile information'),
                      leading: Icon(Icons.person_outline, color: Color(0xFF009CA6)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _showProfileDialog(context),
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('Account Details'),
                      subtitle: Text('View account information'),
                      leading: Icon(Icons.account_balance, color: Color(0xFF009CA6)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _showAccountDetailsDialog(context),
                    ),
                    Divider(height: 1),
                    ListTile(
                      title: Text('Logout'),
                      subtitle: Text('Sign out of your account'),
                      leading: Icon(Icons.logout, color: Colors.red),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _showLogoutDialog(context),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF009CA6), size: 20),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF009CA6),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Password changed successfully')),
              );
            },
            child: Text('Change'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _languages.map((language) {
            return RadioListTile<String>(
              title: Text(language),
              value: language,
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showCurrencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Currency'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _currencies.map((currency) {
            return RadioListTile<String>(
              title: Text(currency),
              value: currency,
              groupValue: _selectedCurrency,
              onChanged: (value) {
                setState(() => _selectedCurrency = value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text('Light'),
              value: 'Light',
              groupValue: 'Light',
              onChanged: (value) => Navigator.pop(context),
            ),
            RadioListTile<String>(
              title: Text('Dark'),
              value: 'Dark',
              groupValue: 'Light',
              onChanged: (value) => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showLoginHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login History'),
        content: Container(
          height: 200,
          child: ListView(
            children: [
              ListTile(
                title: Text('Today, 2:30 PM'),
                subtitle: Text('iPhone 12 - Accra, Ghana'),
                leading: Icon(Icons.check_circle, color: Colors.green),
              ),
              ListTile(
                title: Text('Yesterday, 10:15 AM'),
                subtitle: Text('iPhone 12 - Accra, Ghana'),
                leading: Icon(Icons.check_circle, color: Colors.green),
              ),
              ListTile(
                title: Text('2 days ago, 3:45 PM'),
                subtitle: Text('Web Browser - Accra, Ghana'),
                leading: Icon(Icons.check_circle, color: Colors.green),
              ),
            ],
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

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Profile'),
        content: Text('Profile editing feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAccountDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Account Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Account Number: 1234567890'),
            Text('Account Type: Savings'),
            Text('Branch: Accra Main'),
            Text('Opening Date: 15/01/2020'),
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

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Privacy Policy'),
        content: Text('Our privacy policy ensures your data is protected and used responsibly. Read the full policy on our website.'),
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