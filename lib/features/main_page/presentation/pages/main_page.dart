import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/injection_container.dart';
import '../../../../resources/strings/string_keys.dart';
import '../../../favorites/presentation/pages/favorites_page.dart';
import '../../../translate/domain/entity/language_item_entity.dart';
import '../../../translate/presentation/pages/translate_page.dart';
import '../../data/view_logic/item_bottom_navigation_bar.dart';
import '../../data/view_logic/navigation_bar_list.dart';
import '../bloc/main_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainBloc _navigationBloc;

  final PageController _pageController = PageController();

  int _selectedBottomIndex = 0;
  final List<ItemBottomNavigationBar> _bottomMenuList =
      NavigationBarList.createNavigationBarListItem();
  // list of displayed languages.
  List<LanguageItemEntity> _languages = [];

  @override
  void initState() {
    _navigationBloc = di<MainBloc>();
    _navigationBloc.add(GetAvailableLanguagesEvent());
    _navigationBloc.add(InitPreferredLanguageEvent());
    _navigationBloc.add(GetFavoritesEvent());
    super.initState();
  }

  @override
  void dispose() {
    _navigationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          StringKeys.appTitle,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer(
          bloc: _navigationBloc,
          listener: (context, state) {
            if (state is TranslatePageState) {
              _goToPage(Constants.TRANSLATE_PAGE_INDEX);
            } else if (state is FavoritesPageState) {
              _goToPage(Constants.FAVORITE_PAGE_INDEX);
            } else if (state is LanguageListLoadedState) {
              _languages = state.languages;
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                color: Color(0xffebebeb),
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    TranslatePage(languages: _languages),
                    FavoritesPage(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _buildNavigationBarItems(),
        onTap: (index) {
          _onBottomNavigationBarIconPressed(index);
        },
        currentIndex: _selectedBottomIndex,
        selectedFontSize: 20,
        unselectedFontSize: 18,
        selectedItemColor: Colors.blue,
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationBarItems() {
    List<BottomNavigationBarItem> result = [];
    _bottomMenuList.asMap().forEach((index, element) {
      result.add(BottomNavigationBarItem(
        label: element.label,
        backgroundColor: Colors.white,
        icon: _selectedBottomIndex == index
            ? Icon(element.iconSelected)
            : Icon(element.icon),
      ));
    });
    return result;
  }

  _goToPage(int index) {
    _pageController.jumpToPage(index);
  }

  _onBottomNavigationBarIconPressed(int index) {
    switch (index) {
      case Constants.TRANSLATE_PAGE_INDEX:
        _navigationBloc.add(TranslatePressedEvent());
        break;
      case Constants.FAVORITE_PAGE_INDEX:
        _navigationBloc.add(FavoritesPressedEvent());
        break;
      default:
        _navigationBloc.add(TranslatePressedEvent());
    }

    setState(() {
      _selectedBottomIndex = index;
    });
  }
}
