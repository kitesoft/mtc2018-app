import "package:flutter/material.dart";
import "package:mtc2018_app/model/news.dart";
import "package:mtc2018_app/colors.dart";
import "package:mtc2018_app/localize.dart";
import "package:mtc2018_app/repository/repository.dart";
import "dart:async";

class NewsPage extends StatefulWidget {
  final Repository repository;
  const NewsPage({Key key, this.repository}) : super(key: key);

  @override
  _NewsPageState createState() => new _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<News> _newsList = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final newsList = await widget.repository.getNewsList();
    setState(() {
      _newsList = newsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_newsList.length == 0) {
      return Scaffold(
          appBar: AppBar(
            title: Text(MtcLocalizations.of(context).newsTitle),
            centerTitle: false,
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(MtcLocalizations.of(context).newsTitle),
          centerTitle: false,
        ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: _newsList.map((news) {
              Locale currentLocale = Localizations.localeOf(context);
              var message = currentLocale.languageCode == "ja"
                  ? news.messageJa
                  : news.message;
              return Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: kMtcPrimaryGrey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(height: 4.0),
                                  Text(news.date,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: kMtcPrimaryGrey))
                                ])
                          ],
                        ),
                        Container(height: 12.0),
                        Text(message, style: TextStyle(color: kMtcPrimaryGrey)),
                      ],
                    ),
                  ));
            }).toList(),
          ),
        ));
  }

  Future<Null> _handleRefresh() async {
    final newsList = await widget.repository.refreshNewsList();
    setState(() {
      _newsList = newsList;
    });
    return null;
  }
}
