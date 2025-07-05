class TransactionModel {
  String desc;
  double amount;
  String date;
  String recipient;
  String accountNumber;

  TransactionModel({
    required this.desc,
    required this.amount,
    required this.date,
    required this.recipient,
    required this.accountNumber,
  });
} 