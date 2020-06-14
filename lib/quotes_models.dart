class CacheLog {
  CacheLog(this.id, this.name, this.lastUpdated);

  final int id;
  final String name, lastUpdated;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'lastUpdated': lastUpdated,
      };
}

class Quotes {
  Quotes(
    this.id,
    this.author,
    this.quote,
    this.quoteId,
  );

  final int id;
  final String author, quote, quoteId;

  Map<String, dynamic> toMap() => {
        'id': id,
        'author': author,
        'quote': quote,
        'quoteId': quoteId,
      };
}
