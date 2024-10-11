import 'dart:convert';

import 'package:budget_app/models/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionProvider {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  TransactionProvider() {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? transactionsJson = prefs.getString('transactions');

    if (transactionsJson != null) {
      List<dynamic> transactionList = json.decode(transactionsJson);

      _transactions = transactionList
          .map((transactions) => Transaction.fromMap(transactions))
          .toList();

      notifyListeners();
    }
  }
}
