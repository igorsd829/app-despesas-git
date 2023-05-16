import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../pages/transactions.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(
    this.onSubmit, {
    super.key,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _ValueController = TextEditingController();

  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_ValueController.text) ?? 0.0;

    if (title.isEmpty || value < 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate!);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            TextField(
              onSubmitted: (value) => _submitForm,
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                contentPadding: EdgeInsets.all(5),
              ),
            ),
            TextField(
              onSubmitted: (value) => _submitForm,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: _ValueController,
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
                contentPadding: EdgeInsets.all(5),
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Nenhuma data selecionada'
                          : 'Data selecionada ${DateFormat('dd/MM/y').format(_selectedDate!)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: const Text(
                      'selecione uma data',
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text(
                      'Nova transação',
                    ),
                  ),
                  onPressed: () {
                    _submitForm();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
