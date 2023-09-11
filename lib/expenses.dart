import 'package:flutter/material.dart';
import 'package:todo/widgets/chart/chart.dart';
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
        category: Categorycha.food),
    Expense(
        title: "telefon haqida film",
        amount: 12.00,
        date: DateTime.now(),
        category: Categorycha.leisure)
  ];

  void _openAddExpenseOverly() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onaddexpense: _addexpenses),
    );
  }

  void _addexpenses(value) {
    setState(() {
      _registerExprense.add(value);
    });
  }

  void _removeExpenses(Expense expense) {
    final expenseIndex = _registerExprense.indexOf(expense);

    setState(() {
      _registerExprense.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("expense o'chirildi"),
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: "Qaytarish",
        onPressed: () {
          setState(() {
            _registerExprense.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget maincontent = const Center(
      child: Text("sizda hali ma'lumot  mavjud emas"),
    );

    if (_registerExprense.isNotEmpty) {
      maincontent =
          ExprensesList(expenses: _registerExprense, onremove: _removeExpenses);
    }
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
            Chart(expenses: _registerExprense),
            Expanded(child: maincontent)
          ],
        ));
  }
}
