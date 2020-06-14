import 'package:mobx/mobx.dart';
import 'quotes_models.dart';
import 'api_helper.dart';
import 'constants.dart';

part 'quotes_store.g.dart';

class QuotesListStore = _QuotesListStore with _$QuotesListStore;

abstract class _QuotesListStore with Store {
  _QuotesListStore() {
    getQuotes();
  }

  @observable
  ObservableList allQuotes = ObservableList();

  @action
  Future<void> getQuotes() async {
    await getQuotesFromApi();
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

      allQuotes.add(Quotes(id, author, quote, quoteId));
    }
  }
}
