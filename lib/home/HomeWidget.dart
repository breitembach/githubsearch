import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:programacaoreativa/details/DetailsWidget.dart';
import 'package:programacaoreativa/home/HomeBloc.dart';
import 'package:programacaoreativa/models/SearchResult.dart';
import 'package:programacaoreativa/models/Searchtem.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  HomeBloc bloc;

  @override
  void initState() {
    bloc = HomeBloc();
    super.initState();
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  Widget _textFild() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: bloc.searchEvent.add,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Jacob Moura...",
            labelText: "Pesquisa"),
      ),
    );
  }

  Widget _items(SearchItem item) {
        print("teste");

    return ListTile(
      leading: Hero(
        tag: item.url,
        child: CircleAvatar(
          backgroundImage: NetworkImage(item?.avatarUrl ??
              "https://d2v9y0dukr6mq2.cloudfront.net/video/thumbnail/VCHXZQKsxil3lhgr4/animation-loading-circle-icon-on-white-background-with-alpha-channel-4k-video_sjujffkcde_thumbnail-full01.png"),
        ),
      ),
      title: Text(item?.fullName ?? "title"),
      subtitle: Text(item?.url ?? "url"),
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => DetailsWidget(
                    item: item,
                  ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Github Search"),
      ),
      body: ListView(
        children: <Widget>[
          _textFild(),
          StreamBuilder(
              stream: bloc.listItems,
              builder: (context, AsyncSnapshot<SearchResult> snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          SearchItem item = snapshot?.data.items[index];
                          return _items(item);
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              }),
        ],
      ),
    );
  }
}
