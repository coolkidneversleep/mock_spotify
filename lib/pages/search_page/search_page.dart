import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mockspotify/api/api.dart';
import 'package:mockspotify/models/album_model.dart';
import 'package:mockspotify/pages/album_detail_page/album_detail_page.dart';
import 'package:mockspotify/pages/search_page/widgets/search_list.dart';

import '../../widgets/custom_search_text_filed.dart';

class SearchPage extends HookWidget {
  const SearchPage({super.key});

  static String get path => '/search-page';
  static String get name => 'search_page';

  @override
  Widget build(BuildContext context) {
    final searchTextController = useTextEditingController();
    final searchText = useState('');

    Future<List<AlbumModel>> getSearchResult({
      searchWord = '',
      required void Function(List<AlbumModel> resultList) onSearchSuccess,
    }) async {
      final searchResult = await API.getSearch(searchWord);
      onSearchSuccess(searchResult);
      return searchResult;
    }

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: const Color.fromARGB(255, 18, 16, 16),
              leading: CupertinoButton(
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              flexibleSpace: Container(
                  padding: const EdgeInsets.fromLTRB(45, 4, 0, 0),
                  margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: CustomSearchTextField(
                    autofocus: false,
                    inputController: searchTextController,
                    onClear: () {
                      searchText.value = '';
                    },
                    onChanged: (value) {
                      searchText.value = value;
                    },
                  )),
            ),
            backgroundColor: const Color.fromARGB(255, 18, 16, 16),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(21, 20, 0, 0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SearchList(
                    searchResult: API.getSearch(searchText.value),
                  )),
            )));
  }
}



