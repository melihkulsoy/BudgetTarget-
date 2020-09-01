import 'package:butceappflutter/api/models/Expense.dart';
import 'package:butceappflutter/api/repositories/expense_repository.dart';
import 'package:butceappflutter/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class ExpenseDetailScreen extends StatefulWidget {
  final Expense expense;
  ExpenseDetailScreen({@required this.expense});
  @override
  _ExpenseDetailScreenState createState() => _ExpenseDetailScreenState();
}

class _ExpenseDetailScreenState extends State<ExpenseDetailScreen> {
  ExpenseRepository expenseRepository = new ExpenseRepository();
  final _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: widget.expense.name + ' Details'),
        body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: TextEditingController()
                      ..text = widget.expense.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: TextEditingController()
                      ..text = widget.expense.description,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: TextEditingController()
                      ..text = widget.expense.amount.toString(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: TextEditingController()
                      ..text = widget.expense.city,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'City',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Edit'),
                      color: Colors.blue[800],
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                    SizedBox(width: 20),
                    RaisedButton(
                      color: Colors.red[800],
                      textColor: Colors.white,
                      onPressed: () {
                        this.expenseRepository
                        .delete(widget.expense.id)
                        .then((response) {
                          if(response.statusCode == 200) {
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: Text('Delete'),
                    )
                  ],
                )
              ],
            )));
  }
}
