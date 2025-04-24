import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:intl/intl.dart';
// import 'package:five_pointed_star/five_pointed_star.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: MyForm(),
      )
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyForm createState() => _MyForm();
}

class _MyForm  extends State<MyForm > {
  final _formKey = GlobalKey<FormState>();
  double _familyMembers = 0.0;
  int _rating = 3;
  int _stepperValue = 10;
  bool _agree = false;

  String? _name, _gender;
  DateTime? _dob;
  int? _age;
  final _genders = ['Male', 'Female'];

  bool _isEnglish = false;
  bool _isHindi = false;
  bool _isOther = false;

  final TextEditingController _dobController = TextEditingController();

  final TextEditingController _ratingController = TextEditingController();

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2.0,
    penColor: Colors.black,
    exportPenColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _name = null;
      _dob = null;
      _age = null;
      _gender = null;
      _familyMembers = 0.0;
      _rating = 3;
      _stepperValue = 10;
      _agree = false;
      _isEnglish = false;
      _isHindi = false;
      _isOther = false;
      _dobController.clear();
      _ratingController.clear();
      _signatureController.clear();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dob = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
        _age = DateTime.now().year - picked.year;
        if (DateTime.now().month < picked.month || 
          (DateTime.now().month == picked.month && DateTime.now().day < picked.day)) {
          _age = _age! - 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Form Validation',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple,),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full Name
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) => value == null || value.isEmpty ? 'This field cannot be empty.' : null,
                onSaved: (value) => _name = value,
              ),

              // Date of Birth
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your date of birth';
                  }
                  return null;
                },
              ),

              // Gender Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select Gender'),
                items: _genders.map((gender) {
                  return DropdownMenuItem(value: gender, child: Text(gender));
                }).toList(),
                onChanged: (val) => _gender = val,
                validator: (value) => value == null ? 'This field cannot be empty.' : null,
              ),

              // Age
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                readOnly: true,
                controller: TextEditingController(text: _age != null ? _age.toString() : ''),
              ),

              SizedBox(height: 16),

              // Number of Family Members
              Text("Number of Family Members"),
              Slider(
                value: _familyMembers,
                min: 0,
                max: 10,
                divisions: 20,
                label: _familyMembers.toString(),
                onChanged: (val) {
                  setState(() => _familyMembers = val);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("0.0"),
                  Text(_familyMembers.toStringAsFixed(1)), // live value in the middle
                  Text("10.0"),
                ],
              ),
              Divider(),
              

              // Rating (1 to 5)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rating', style: TextStyle(fontSize: 14)),
                    SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 1.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(5, (index) {
                          int number = index + 1;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _ratingController.text = number.toString();
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color:
                                      _ratingController.text == number.toString()
                                          ? Colors.purple.shade100
                                          : Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    number.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              // Stepper
              SizedBox(height: 16),
              Text("Stepper"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    IconButton(onPressed: () => setState(() => _stepperValue--), icon: Icon(Icons.remove)),
                    Text("$_stepperValue"),
                    IconButton(onPressed: () => setState(() => _stepperValue++), icon: Icon(Icons.add)),
                  ],
              ),
              Divider(),

              // Languages You Know
              Text("Languages you know"),
              CheckboxListTile(
                title: Text("English"),
                value: _isEnglish,
                onChanged: (val) {
                  setState(() {
                    _isEnglish = val!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Hindi"),
                value: _isHindi,
                onChanged: (val) {
                  setState(() {
                    _isHindi = val!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Other"),
                value: _isOther,
                onChanged: (val) {
                  setState(() {
                    _isOther = val!;
                  });
                },
              ),
              Divider(),

              // Placeholder for Signature
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Signature', style: TextStyle(fontSize: 15)),
                    SizedBox(height: 14),
                    Container(
                      width: 500,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.3),
                      ),
                      child: Signature(
                        controller: _signatureController,
                        backgroundColor: Colors.white,
                        dynamicPressureSupported: true,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.clear),
                          style: IconButton.styleFrom(
                            //backgroundColor: Colors.red,
                            foregroundColor: Colors.red,
                          ),
                          onPressed: () {
                            _signatureController.clear();
                          },
                        ),
                        Text(
                          'Clear',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              //Rate this site
              Text("Rate this site"),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: index < _rating ? Colors.purple : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  );
                }),
              ),
              Divider(),

              // Terms and Conditions
              CheckboxListTile(
                title: Text("I have read and agree to the terms and conditions"),
                value: _agree,
                onChanged: (val) => setState(() => _agree = val!),
              ),
              if (!_agree)
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text("You must accept terms and conditions to continue",
                      style: TextStyle(color: Colors.red)),
                ),
              Divider(),

              SizedBox(height: 16),

              // Submit and Reset
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _agree) {
                        _formKey.currentState!.save();
                        // Do something with the data
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form submitted')));
                      }
                    },
                  ),
                  OutlinedButton(
                    child: Text('Reset'),
                    onPressed: _resetForm,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
