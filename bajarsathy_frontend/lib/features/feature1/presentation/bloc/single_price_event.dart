abstract class SinglePriceEvent {}

class FetchSingleDataEvent extends SinglePriceEvent {
  final String product_name;
  FetchSingleDataEvent(this.product_name);
}
