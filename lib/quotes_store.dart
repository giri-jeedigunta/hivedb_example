import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'quotes_models.dart';
import 'api_helper.dart';
import 'constants.dart';
import 'package:path_provider/path_provider.dart';

part 'quotes_store.g.dart';

class QuotesListStore = _QuotesListStore with _$QuotesListStore;

abstract class _QuotesListStore with Store {
  _QuotesListStore() {
    initHive();
  }

  @observable
  ObservableList allQuotes = ObservableList();

  @action
  Future<void> getQuotes() async {
    final quotesFromBox = await Hive.openBox('quotes');
    if (quotesFromBox.length == 0) {
      await getQuotesFromApi();
    } else {
      updateQuotesList();
    }
  }

  Future<void> initHive() async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentsDirectory.path);
    Hive.registerAdapter(QuotesAdapter());
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

  updateQuotesList() async {}
}
