import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatelessWidget {
  String title;
  String thumbnail;
  String description;
  String link;
  String pubDate;

  ProductDetail({
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.link,
    required this.pubDate,
  });

  Future<void> goToWebPage(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text('News Detail'),
            centerTitle: true,
            backgroundColor: Colors.teal),
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(18),
          height: double.infinity,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 3,
                    ),
                    Text(
                      DateFormat('EEEE, dd MMMM yyyy')
                          .format(DateTime.parse(pubDate)),
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.4,
                      child: Image.network(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        thumbnail.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      description.toString(),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16,
                        wordSpacing: 3,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 100,),
                        Row(
                          children: [
                            SizedBox(width: 280,),
                            Container(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(Colors.teal),
                                ),
                                onPressed: () async {
                                  await goToWebPage(link.toString());
                                }, child: Text('Baca Selengkapnya..'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
