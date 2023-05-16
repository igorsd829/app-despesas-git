import 'dart:math';

import 'package:despessas/components/transaction_form.dart';
import 'package:despessas/components/transaction_list.dart';
import 'package:despessas/pages/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/chart.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(
            _addTransaction,
          );
        });
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      actions: [
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: const Icon(
            Icons.add,
          ),
        )
      ],
      title: Text(
        'Despesas pessoais',
        style: TextStyle(
          fontSize: 20 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Exibir o gráfico'),
                Switch(
                    activeColor: Colors.yellow,
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    }),
              ],
            ),
            if (_showChart)
              Container(
                height: availableHeight * 0.3,
                child: Chart(_recentTransactions),
              ),
            if (!_showChart)
              Container(
                height: availableHeight * 0.7,
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _openTransactionFormModal(context);
          },
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
