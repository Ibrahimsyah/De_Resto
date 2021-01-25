class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({this.name, this.review, this.date});

  CustomerReview.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    review = json['review'];
    date = json['date'];
  }
}
