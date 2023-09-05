import 'package:flutter/material.dart';
import 'package:todo/models/expense.dart';
import 'package:todo/widgets/expenses_item.dart';

class ExprensesList extends StatelessWidget {
  const ExprensesList({super.key, required this.expenses});
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => ExpensesItem(expenses[index]));
  }
}
