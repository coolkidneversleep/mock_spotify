import 'package:flutter/material.dart';
import 'package:mockspotify/pages/search_page/widgets/search_item.dart';

import '../../../models/album_model.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.searchResult});
  final Future<List<AlbumModel>?> searchResult;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: searchResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final dataList = snapshot.data ?? [];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dataList.isEmpty
                    ? Column(
                        children: const [
                          Text(
                            'Play What you love',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Search for albums.',
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: dataList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return SearchItem(
                                  albumId: dataList[index].id,
                                  image: dataList[index].images[0].url,
                                  title: dataList[index].name,
                                  subtitle:
                                      '${dataList[index].type} · ${dataList[index].artists[0].name}');
                            }),
                      ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [Center(child: CircularProgressIndicator())],
          );
        });
  }
}
