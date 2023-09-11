import 'package:flutter/material.dart';
import 'package:todo/models/expense.dart';
import 'package:todo/widgets/expenses_item.dart';

class ExprensesList extends StatelessWidget {
  const ExprensesList(
      {super.key, required this.expenses, required this.onremove});
  final List<Expense> expenses;

  final void Function(Expense expense) onremove;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
            background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.74)),
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              onremove(expenses[index]);
            },
            child: ExpensesItem(expenses[index])));
  }
}
