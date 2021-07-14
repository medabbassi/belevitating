class Quote {
  final String text;
  final String? author;
  Quote.fromJson(Map json)
  : text =json['text'],
    author =json['author'];
  Map toJson(){
    return {'text': text, 'author': author};
  }

}