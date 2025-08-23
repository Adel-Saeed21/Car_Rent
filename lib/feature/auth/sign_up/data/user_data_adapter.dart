import 'package:carrent/feature/auth/sign_up/data/user_data.dart';
import 'package:hive/hive.dart';

class UserDataAdapter extends TypeAdapter<UserData> {
  @override
  final int typeId = 0;

  @override
  UserData read(BinaryReader reader) {
    return UserData(
      uid: reader.readString(),
      email: reader.readString(),
      name: reader.readString(),
      phone: reader.readString(),
      favouriteCars: reader.readList().cast<String>(),
      profileImagePath: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, UserData obj) {
    writer.writeString(obj.uid ?? '');
    writer.writeString(obj.email ?? '');
    writer.writeString(obj.name ?? '');
    writer.writeString(obj.phone ?? '');
    writer.writeList(obj.favouriteCars ?? []);
    writer.writeString(obj.profileImagePath ?? '');
  }
}
