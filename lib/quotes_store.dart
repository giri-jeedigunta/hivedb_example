import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'quotes_models.dart';
import 'api_helper.dart';
import 'constants.dart';
import 'package:path_provider/path_provider.dart';

part 'quotes_store.g.dart';

class QuotesListStore = _QuotesListStore with _$QuotesListStore;

abstract class _QuotesListStore with Store {
  // _QuotesListStore() {
  //   initHive();
  // }

  @observable
  ObservableList allQuotes = ObservableList();

  @observable
  bool initHiveDB = false;

  @action
  Future<void> getQuotes() async {
    if (!initHiveDB) {
      initHive();
      return;
    }
    final quotesFromBox = await Hive.openBox('quotes');
    if (quotesFromBox.length == 0) {
      await getQuotesFromApi();
    } else {
      await updateQuotesList();
    }
  }

  Future<void> initHive() async {
    if (!initHiveDB) {
      final appDocumentsDirectory = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentsDirectory.path);
      Hive.registerAdapter(QuotesAdapter());
      initHiveDB = true;
      await getQuotes();
    }
  }

  Future<void> getQuotesFromApi() async {
    final apiHelper = ApiService('$kBaseApiURL/page/1');
    final data = await apiHelper.getResponse();
    int counter = 0;

    for (int i = 0; i < data.length; i++) {
      final cardItem = data[i];
      final id = counter++;
      final quoteId = cardItem['id'];
      final author = cardItem['author'];
      final quote = cardItem['en'];

      Hive.box('quotes').add(Quotes(id, author, quote, quoteId));
    }

    /*  
    This step is an additional hop and unnecessary 
    I still have to figure out to make MobX observe custom type 
    */
    updateQuotesList();
  }

  /* TODO: Should avoid this step. 
     Note: Have to figure out a way to directly observe the type box 
     and avoid copying from box to list
  */
  Future<void> updateQuotesList() async {
    final quotesFromBox = await Hive.openBox('quotes');
    for (int i = 0; i < quotesFromBox.length; i++) {
      allQuotes.add(quotesFromBox.get(i));
    }
  }
}
