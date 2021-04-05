import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/favorites/domain/entity/favorite_text_entry_entity.dart';
import '../../features/favorites/domain/entity/favorites_entity.dart';

class HiveInit {
  static init() async {
    Hive.initFlutter();
    Hive.registerAdapter(FavoritesEntityAdapter());
    Hive.registerAdapter(FavoriteTextEntryEntityAdapter());
  }
}
