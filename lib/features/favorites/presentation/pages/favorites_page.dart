import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection_container.dart';
import '../../../../core/singleton/user_details.dart';
import '../../domain/entity/favorite_text_entry_entity.dart';
import '../bloc/favorites_bloc.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoritesBloc _favoritesBloc;

  @override
  void initState() {
    _favoritesBloc = di<FavoritesBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _favoritesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _favoritesBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int itemIndex) {
                return _buildFavoriteItem(itemIndex,
                    di<UserDetails>().favorites.elementAt(itemIndex));
              },
              itemCount: di<UserDetails>().favorites.length,
            ),
          );
        });
  }

  _buildFavoriteItem(int index, FavoriteTextEntryEntity entity) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0, 2.0)),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entity.textToBeTranslated),
                    SizedBox(height: 10),
                    Text(
                      entity.translatedText,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    setState(() {
                      di<UserDetails>().favorites.remove(entity);
                    });
                    _favoritesBloc.add(RemoveFavorite(favorite: entity));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
