import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'detail.dart';

class pageIslam extends StatefulWidget {
  const pageIslam({super.key});

  @override
  State<pageIslam> createState() => _pageIslamState();
}

class _pageIslamState extends State<pageIslam> {
  List<Map<String, dynamic>> home = [];
  bool load = false;

  @override
  void initState() {
    super.initState();
    fetchHome();
  }

  fetchHome() async {
    setState(() {
      load = true;
    });
    var url = "https://api-berita-indonesia.vercel.app/republika/islam";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> items = data['data']['posts'];

      setState(() {
        home = items
            .map((item) => {
                  'title': item['title'],
                  'thumbnail': item['thumbnail'],
                  'description': item['description'],
                  'link': item['link'],
                  'pubDate': item['pubDate']
                })
            .toList();
        load = false;
      });
    } else {
      setState(() {
        home = [];
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REPUBLIKA ISLAM"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    // ignore: prefer_is_empty
    if (home.contains(null) || home.length < 0 || load) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
      ));
    }
    return ListView.builder(
        itemCount: home.length,
        itemBuilder: (context, index) {
          return getCard(home[index]);
        });
  }

  Widget getCard(item) {
    //nama=>nama di api
    var title = item['title'];
    var thumbnail = item['thumbnail'];
    var description = item['description'];
    var link = item['link'];
    var pubDate = item['pubDate'];

    return Card(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetail(
                title: title,
                thumbnail: thumbnail,
                description: description,
                link: link,
                pubDate: pubDate,
              ))),
          child: Container(
            height: MediaQuery.of(context).size.height / 7,
            child: Row(
              children: [
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.height * 0.5,
                  child:
                  Text(
                    title.toString(),
                    style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 4,
                  ),
                ),
                ClipRRect(
                    child: Image.network(
                      width: MediaQuery.of(context).size.height * 0.23,
                      height: 150,
                      thumbnail.toString(),
                      fit: BoxFit.fill,
                    )),
              ],

            ),
          ),
        ));
  }
}
