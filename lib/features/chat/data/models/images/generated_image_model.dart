class GeneratedImageModel {
  int created;
  String b64Json;

  GeneratedImageModel({required this.created, required this.b64Json});

  factory GeneratedImageModel.fromJson(Map<String, dynamic> json) {
    return GeneratedImageModel(
      created: json['created'],
      b64Json: List.from(json['data']).first['b64_json'],
    );
  }
}
