import 'package:flutter/material.dart';
import 'package:flutter_staff/home_page/user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TextForm extends StatefulWidget {
  final Function(User) onEmployeeAdded;
  const TextForm({super.key, required this.onEmployeeAdded});

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> with WidgetsBindingObserver {
  final _surname = TextEditingController();
  final _name = TextEditingController();
  final _patronymic = TextEditingController();
  final _number = TextEditingController();

  final surnameFocus = FocusNode();
  final nameFocus = FocusNode();
  final patronymicFocus = FocusNode();
  final numberFocus = FocusNode();

  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _surname.dispose();
    _name.dispose();
    _patronymic.dispose();
    _number.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset == 0) {
      _unfocusAllFields();
    }
  }

  void _unfocusAllFields() {
    surnameFocus.unfocus();
    nameFocus.unfocus();
    patronymicFocus.unfocus();
    numberFocus.unfocus();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      }
    });
  }

  void saveUser() {
    final newUser = User(
      Surname: _surname.text,
      Name: _name.text,
      Patronymic: _patronymic.text,
      Number: _number.text,
    );
    widget.onEmployeeAdded(newUser);
  }

  User newUser = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Регистрация нового сотрудника',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              saveUser();
              Navigator.of(context).pop(newUser);
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      margin: const EdgeInsets.all(15.0),
                      width: 150,
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: _image == null
                          ? const Center(
                              child: Icon(
                              Icons.person,
                              size: 80,
                            ))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                File(_image!.path),
                                fit: BoxFit.cover,
                                width: 150,
                                height: 170,
                              ),
                            ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _surname,
                          focusNode: surnameFocus,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            labelText: 'Фамилия',
                          ),
                          onChanged: (value) => newUser.Surname = value,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _name,
                          focusNode: nameFocus,
                          decoration: const InputDecoration(
                            labelText: 'Имя',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          onChanged: (value) => newUser.Name = value,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _patronymic,
                          focusNode: patronymicFocus,
                          decoration: const InputDecoration(
                            labelText: 'Отчество',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          onChanged: (value) => newUser.Patronymic = value,
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: _number,
                focusNode: numberFocus,
                decoration: const InputDecoration(
                  labelText: 'Номер телефона',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                onChanged: (value) => newUser.Number = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
