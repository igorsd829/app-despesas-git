import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../pages/transactions.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Lista de transação',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/img/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tr = transactions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: FittedBox(
                          child: Text(
                            'R\$ ${tr.value}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                    trailing: IconButton(
                      color: Theme.of(context).errorColor,
                      icon: Icon(Icons.delete),
                      onPressed: () => onRemove(tr.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
