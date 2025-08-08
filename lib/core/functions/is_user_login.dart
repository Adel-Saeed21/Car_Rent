import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:hive/hive.dart';

bool isUserLoggedIn() {
  final box = Hive.box<UserData>('userDataBox');
  return box.get('currentUser') != null;
}
