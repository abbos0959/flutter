import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final dateFormatter = DateFormat.yMd();

enum Categorycha { food, travel, leisure, work }

const categoryIcon = {
  Categorycha.food: Icons.lunch_dining,
  Categorycha.work: Icons.work,
  Categorycha.leisure: Icons.movie,
  Categorycha.travel: Icons.flight_takeoff,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String title;
  final double amount;
  final DateTime date;
  final String id;
  final Categorycha category;
  String get formattedDate {
    return dateFormatter.format(date);
  }
}

class ExpensesBucket {
  const ExpensesBucket({required this.category, required this.expensescha});
  ExpensesBucket.forCategory(List<Expense> allExpense, this.category)
      : expensescha = allExpense
            .where((element) => element.category == category)
            .toList();

  final Categorycha category;
  final List<Expense> expensescha;
  double get totalExpense {
    double sum = 0;
    for (final expense in expensescha) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
