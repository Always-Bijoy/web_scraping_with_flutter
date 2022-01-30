import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class JagoNewsBd extends StatefulWidget {
  const JagoNewsBd({Key? key}) : super(key: key);

  @override
  _JagoNewsBdState createState() => _JagoNewsBdState();
}

class _JagoNewsBdState extends State<JagoNewsBd> {
  List<String> title = [];
  List<String> post = [];
  List<String?> link = [];
  List<String?> image = [];

  void _getData() async {
    final response = await http.get(Uri.parse('https://www.jagonews24.com/sports/'));
    // final response = await http
    //     .get(Uri.parse('http://www.tigercricket.com.bd/category/featured/'));
    dom.Document document = parser.parse(response.body);
    final elements = document.getElementsByClassName('paddingTop10 paddingRight10');
    final element2= document.getElementsByClassName('entry-content');
    final linkElemnt=document.getElementsByClassName('paddingTop10 paddingRight10');

    final imageElement = document.getElementsByClassName('img-box');


    // final elements =
    //     document.getElementsByClassName('entry-title td-module-title');
    // // final element2= document.getElementsByClassName('entry-content');
    // final linkElemnt = document.getElementsByClassName('td-module-thumb');
    setState(() {
      title = elements
          .map((element) => element.getElementsByTagName("a")[0].innerHtml)
          .toList();
      // post = element2
      //     .map((element) =>
      // element.getElementsByTagName("p")[0].innerHtml)
      //     .toList();
      link = linkElemnt
          .map((element) =>
      element.getElementsByTagName("a")[0].attributes['href'])
          .toList();
      image = imageElement
          .map((element) =>
      element.getElementsByTagName("img")[0].attributes['src'])
          .toList();
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: title.length == 0
          ? Text("zeroo")
          : ListView.builder(
        itemCount: title.length,
        itemBuilder: (context, index) {
          print(image[index]);
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () async {
                    dynamic url = link[index];
                    if (await canLaunch(url))
                      launch(url);
                    else {
                      print('error');
                    }
                    print(link[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        color: Colors.black87,
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                title[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            if (link.isNotEmpty)
                              Text(
                                '${link[index]}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            Image.network('${image[index]}'),
                            Text('${image[index]}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
