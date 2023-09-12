import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onaddexpense});

  final void Function(Expense expense) onaddexpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  Categorycha _selectedCategory = Categorycha.food;
  DateTime? _SelectedDate;

  void _presentDataPicker() async {
    final now = DateTime.now();
    final firstdata = DateTime(now.year - 1, now.month, now.day);
    // final lastdata = DateTime(now.year - 1 + 100, now.month, now.day);
    final picedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdata,
        lastDate: now);

    setState(() {
      _SelectedDate = picedDate;
    });
  }

  void _submitExpansedate() {
    final enteredAmount = double.tryParse(_amountController.text);
    final checkamount = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        checkamount ||
        _SelectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Inputga ma'lumotlar kiritilmagan"),
                content: const Text("Iltimos title, amount va sanani tanlang"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text(
                        "ok",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ));
      return;
    }
    widget.onaddexpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _SelectedDate!,
        category: _selectedCategory));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, contraints) {
      final width = contraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 48, 15, keyboard + 16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text("davay kiritchi nimadir"),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            prefixText: "\$",
                            label: Text("davay narxni kiritchi ")),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _SelectedDate == null
                              ? "sanani tanla ukajon"
                              : dateFormatter.format(_SelectedDate!),
                        ),
                        IconButton(
                            onPressed: _presentDataPicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    )),
                  ],
                ),
                const SizedBox(
                  height: 22,
                ),
                //
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedCategory,
                        items: Categorycha.values
                            .map((val) => DropdownMenuItem(
                                  value: val,
                                  child: Text(val.name.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            _selectedCategory = value;
                          });
                        }),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Bekor qilish",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      onPressed: _submitExpansedate,
                      child: const Text(
                        "Saqlash",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
