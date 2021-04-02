import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../features/favorites/domain/entity/favorite_text_entry_entity.dart';
import '../../features/favorites/domain/entity/favorites_entity.dart';

class HiveInit {
  static init() async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(FavoritesEntityAdapter());
    Hive.registerAdapter(FavoriteTextEntryEntityAdapter());
  }
}
