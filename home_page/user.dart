import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  User({
    this.Surname = '',
    this.Name = '',
    this.Patronymic = '',
    this.Number = '',
  });

  @HiveField(0)
  String? Surname;
  @HiveField(1)
  String? Name;
  @HiveField(2)
  String? Patronymic;
  @HiveField(3)
  String? Number;
}
