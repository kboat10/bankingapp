import 'package:flutter/material.dart';
import '../models/account_model.dart';
import '../models/transaction_model.dart';

class AccountsProvider extends ChangeNotifier {
  // Store accounts and transactions per user (using user name as key)
  Map<String, List<AccountModel>> _userAccounts = {};
  Map<String, List<TransactionModel>> _userTransactions = {};

  // Get accounts for current user
  List<AccountModel> getAccountsForUser(String userName) {
    if (!_userAccounts.containsKey(userName)) {
      // Initialize default accounts for new user
      _userAccounts[userName] = [
        AccountModel(type: 'Savings', number: '1234567890', balance: 5200.75),
        AccountModel(type: 'Current', number: '0987654321', balance: 1500.00),
      ];
    }
    return _userAccounts[userName]!;
  }

  // Get transactions for current user
  List<TransactionModel> getTransactionsForUser(String userName) {
    if (!_userTransactions.containsKey(userName)) {
      // Initialize default transactions for new user
      _userTransactions[userName] = [
        TransactionModel(desc: 'Airtime Purchase', amount: -20.0, date: '2024-06-01', recipient: 'MTN', accountNumber: '1234567890'),
        TransactionModel(desc: 'Salary Credit', amount: 2000.0, date: '2024-05-30', recipient: 'Employer', accountNumber: '1234567890'),
        TransactionModel(desc: 'Transfer to Jane', amount: -150.0, date: '2024-05-28', recipient: 'Jane', accountNumber: '0987654321'),
      ];
    }
    return _userTransactions[userName]!;
  }

  // Get all accounts (for backward compatibility)
  List<AccountModel> get accounts {
    // Return empty list if no current user context
    return [];
  }

  // Get all transactions (for backward compatibility)
  List<TransactionModel> get transactions {
    // Return empty list if no current user context
    return [];
  }

  void transferFunds({
    required String userName,
    required int fromAccountIndex,
    required String recipient,
    required double amount,
    String description = '',
  }) {
    final userAccounts = getAccountsForUser(userName);
    final userTransactions = getTransactionsForUser(userName);
    
    if (userAccounts[fromAccountIndex].balance >= amount) {
      userAccounts[fromAccountIndex].balance -= amount;
      userTransactions.insert(
        0,
        TransactionModel(
          desc: description.isNotEmpty ? description : 'Transfer',
          amount: -amount,
          date: DateTime.now().toIso8601String().substring(0, 10),
          recipient: recipient,
          accountNumber: userAccounts[fromAccountIndex].number,
        ),
      );
      notifyListeners();
    }
  }

  // Add transaction for specific user
  void addTransactionForUser(String userName, TransactionModel transaction) {
    final userTransactions = getTransactionsForUser(userName);
    userTransactions.insert(0, transaction);
    notifyListeners();
  }

  // Update account balance for specific user
  void updateAccountBalanceForUser(String userName, int accountIndex, double newBalance) {
    final userAccounts = getAccountsForUser(userName);
    if (accountIndex < userAccounts.length) {
      userAccounts[accountIndex].balance = newBalance;
      notifyListeners();
    }
  }

  // Get transactions for specific account
  List<TransactionModel> getTransactionsForAccount(String userName, String accountNumber) {
    final userTransactions = getTransactionsForUser(userName);
    return userTransactions.where((transaction) => transaction.accountNumber == accountNumber).toList();
  }

  // Clear user data (for logout)
  void clearUserData(String userName) {
    _userAccounts.remove(userName);
    _userTransactions.remove(userName);
    notifyListeners();
  }
} 