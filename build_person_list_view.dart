import 'package:flutter/material.dart';
import 'package:flutter_staff/home_page/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BuildPersonListView extends StatefulWidget {
  const BuildPersonListView({Key? key}) : super(key: key);

  @override
  State<BuildPersonListView> createState() => _BuildPersonListViewState();
}

class _BuildPersonListViewState extends State<BuildPersonListView> {
  late Box<User> userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box<User>('users');
  }

  void _deleteUser(User user) {
    userBox.delete(user.key);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: userBox.listenable(),
      builder: (context, Box<User> box, _) {
        final users = box.values.toList().cast<User>();

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Align(
              child: Center(
                child: Container(
                  height: 170,
                  margin: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 3, 3, 3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                'assets/icons/lgv9s1kz-removebg-preview.png',
                              ),
                            ),
                            const SizedBox(width: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Фамилия: ${user.surname}'),
                                const SizedBox(width: 15),
                                Text('Имя: ${user.name}'),
                                const SizedBox(width: 15),
                                Text('Отчество: ${user.patronymic}'),
                                const SizedBox(width: 15),
                                Text('Номер: ${user.number}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 7,
                        right: 5,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 7,
                        right: 5,
                        child: IconButton(
                          onPressed: () {
                            _deleteUser(user);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
