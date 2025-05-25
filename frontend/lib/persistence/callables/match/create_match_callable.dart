import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/persistence/backend/backend.dart';

class CreateMatchCallable {
  Future call({required Room room}) => Backend.createMatch(room);
}
