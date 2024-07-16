import 'package:flutter/material.dart';
import 'package:flutter_staff/home_page/build_person_list_view.dart';
import 'package:flutter_staff/home_page/text_form.dart';
import 'package:flutter_staff/home_page/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddingAPerson extends StatefulWidget {
  const AddingAPerson({super.key});

  @override
  State<AddingAPerson> createState() => _AddingAPersonState();
}

class _AddingAPersonState extends State<AddingAPerson> {
  late Box<User> userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box<User>('users');
  }

  void _addUser(User user) {
    setState(() {
      userBox.add(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 0, 0),
                  Color.fromARGB(255, 255, 255, 255),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                        'assets/icons/lgv9s1kz-removebg-preview.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 260, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            size: 25,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.sort,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const BuildPersonListView(
                scrollOffset: 0.0,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 17, 0),
        onPressed: () {
          showModalBottomSheet<User>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: FractionallySizedBox(
                  heightFactor: 0.53,
                  child: TextForm(
                    onEmployeeAdded: _addUser,
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.person_add,
          color: Color.fromARGB(255, 255, 255, 255),
          size: 40,
        ),
      ),
    );
  }
}
