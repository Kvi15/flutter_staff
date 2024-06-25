import 'package:flutter/material.dart';
import 'package:flutter_staff/archive/archive_page.dart';
import 'package:flutter_staff/home_page/build_person_list_view.dart';
import 'package:flutter_staff/home_page/text_form.dart';
import 'package:flutter_staff/home_page/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddingAPerson extends StatefulWidget {
  const AddingAPerson({Key? key}) : super(key: key);

  @override
  State<AddingAPerson> createState() => _AddingAPersonState();
}

class _AddingAPersonState extends State<AddingAPerson>
    with SingleTickerProviderStateMixin {
  late Box<User> userBox;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box<User>('users');
    _tabController = TabController(length: 2, vsync: this);
  }

  void _addUser(User user) {
    setState(() {
      userBox.add(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(0),
                ),
                color: Color.fromARGB(255, 255, 0, 0),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.asset(
                          'assets/icons/lgv9s1kz-removebg-preview.png',
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [],
                ),
              ],
            ),
          ),
          CustomScrollView(
            slivers: [
              StreamBuilder(
                stream: userBox.watch(),
                builder: (context, snapshot) {
                  return SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    expandedHeight: MediaQuery.of(context).size.height * 0.35,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Padding(
                        padding: const EdgeInsets.only(top: 230),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                _tabController.animateTo(0);
                              },
                              icon: const Icon(
                                Icons.person,
                                size: 35,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                _tabController.animateTo(1);
                              },
                              icon: const Icon(
                                Icons.archive,
                                size: 35,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SliverFillRemaining(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    BuildPersonListView(),
                    ArchivePage(),
                  ],
                ),
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
              return FractionallySizedBox(
                heightFactor: 0.5,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
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
