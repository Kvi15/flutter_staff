import 'package:flutter/material.dart';
import 'package:flutter_staff/home_page/text_form.dart';
import 'package:flutter_staff/home_page/user.dart';
import 'package:hive/hive.dart';

class AddingAPerson extends StatefulWidget {
  const AddingAPerson({super.key});

  @override
  State<AddingAPerson> createState() => _AddingAPersonState();
}

class _AddingAPersonState extends State<AddingAPerson> {
  List<User> users = [];
  late Box<User> usersBox;

  @override
  void initState() {
    super.initState();
    usersBox = Hive.box<User>('usersBox');
    loadUsers();
  }

  void loadUsers() {
    setState(() {
      users = usersBox.values.toList();
    });
    debugPrint('Пользователи загружены: ${users.length}');
  }

  void _addContainer(User? user) {
    if (user == null) return;

    debugPrint('Добавление пользователя: ${user.Name} ${user.Surname}');

    setState(() {
      users.add(user);
      usersBox.add(user);
    });

    debugPrint('Текущее количество пользователей: ${users.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    key: UniqueKey(),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Dismissible(
                          key: Key('container_$index'),
                          background: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                          secondaryBackground: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(
                              Icons.archive,
                              color: Colors.blue,
                              size: 40,
                            ),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              usersBox.deleteAt(index);
                              users.removeAt(index);
                            });
                            debugPrint(
                                'Пользователь удален: ${user.Name} ${user.Surname}');
                          },
                          child: Container(
                            height: 200,
                            margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 3, 3, 3),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: const Color.fromARGB(255, 224, 224, 224),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Фамилия: ${user.Surname}'),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text('Имя: ${user.Name}'),
                                      const SizedBox(width: 15),
                                      Text('Отчество: ${user.Patronymic}'),
                                      const SizedBox(width: 15),
                                      Text('Номер: ${user.Number} '),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: SizedBox(
                width: 70.0,
                height: 70.0,
                child: FloatingActionButton(
                  onPressed: () async {
                    final user = await showModalBottomSheet<User>(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 0.5,
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: TextForm(
                              onEmployeeAdded: (newUser) {
                                Navigator.pop(context, newUser);
                              },
                            ),
                          ),
                        );
                      },
                    );
                    _addContainer(user);
                  },
                  child: const Icon(
                    Icons.add_circle,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
