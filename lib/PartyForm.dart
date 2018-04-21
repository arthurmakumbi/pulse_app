import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  MyFormState MFS;
  MyFormState createState() {
    MFS = new MyFormState();
    return MFS;
  }
  String get partyName{
    return MFS.p_partyName;
  }
  String get password{
    return MFS.p_password;
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyFormState extends State<MyForm> {
  // Create a global key that will uniquely identify the `Form` widget
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String partyName;
  String password;

  String get p_partyName {
    return this.partyName;
  }

  String get p_password {
    return this.password;
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return new Form(
      key: _formKey,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Divider(),
          new Text("Enter a Party Name:", style:TextStyle(fontSize: 18.0)),
          new TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              else {
                this.partyName = value;
              }
            },
          ),
          new Divider(),
          new Text("Enter a Password:", style:TextStyle(fontSize: 18.0)),
          new TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              else {
                this.password = value;
              }
            },
          ),
          new Divider(),
          new Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: new RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  Navigator.pop(context);
                }
              },
              child: new Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}