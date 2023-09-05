import 'package:flutter/material.dart';
import 'package:todo/widgets/expense_list.dart';
import 'package:todo/models/expense.dart';
import 'package:todo/widgets/new_expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExprense = [
    Expense(
        title: "sumkacha",
        amount: 9.00,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "telefon haqida film",
        amount: 12.00,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void _openAddExpenseOverly() {
    showModalBottomSheet(
        context: context, builder: (ctx) => const NewExpense());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Buni kuchli dasturchi yozgan.",
              style: TextStyle(color: Colors.orange),
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(
                      color: Colors.white, // Border rangi
                      width: 2.0, // Border qalinligi
                    )),
                child: IconButton(
                  onPressed: _openAddExpenseOverly,
                  icon: const Icon(Icons.add),
                  color: Colors.white,
                ),
              ),
            ]),
        body: Column(
          children: [
            const Text("bu chartcha"),
            Expanded(
              child: ExprensesList(expenses: _registerExprense),
            )
          ],
        ));
  }
}
