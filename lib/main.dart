import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hivedb_example/quotes_store.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<QuotesListStore>(create: (_) => QuotesListStore()),
        ],
        child: MaterialApp(
          home: MyHomePage(),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final quotesList = Provider.of<QuotesListStore>(context);
    quotesList.getQuotes();
    return Scaffold(
      appBar: AppBar(
        title: Text('HiveDB + MobX'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Random Quotes List',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DancingScript',
                ),
              ),
            ),
            Expanded(
              child: Observer(
                  builder: (_) => quotesList.allQuotes.isNotEmpty
                      ? ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: quotesList.allQuotes.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            child: RichText(
                              text: TextSpan(
                                text: '${quotesList.allQuotes[index].quote}',
                                style: TextStyle(
                                  fontFamily: 'DancingScript',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  height: 1.5,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '\n - ${quotesList.allQuotes[index].author}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            color: Colors.redAccent,
                            thickness: 1,
                          ),
                        )
                      : Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            child: const CircularProgressIndicator(),
                          ),
                        )),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
