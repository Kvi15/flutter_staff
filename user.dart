import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late String surname;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String patronymic;

  @HiveField(3)
  late String number;

  User({
    this.surname = '',
    this.name = '',
    this.patronymic = '',
    this.number = '',
  });
}
