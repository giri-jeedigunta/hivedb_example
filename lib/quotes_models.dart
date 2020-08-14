import 'package:hive/hive.dart';

part 'quotes_models.g.dart';

@HiveType(typeId: 0)
class Quotes {
  Quotes(
    this.id,
    this.author,
    this.quote,
    this.quoteId,
  );

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String author;

  @HiveField(2)
  final String quote;

  @HiveField(3)
  final String quoteId;
}
