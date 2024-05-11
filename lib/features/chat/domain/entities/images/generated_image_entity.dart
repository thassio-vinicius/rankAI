import 'package:equatable/equatable.dart';
import 'package:rankai/features/chat/data/models/images/generated_image_model.dart';

class GeneratedImageEntity extends Equatable {
  final int created;
  final String b64Json;

  const GeneratedImageEntity({
    required this.created,
    required this.b64Json,
  });

  factory GeneratedImageEntity.fromModel(GeneratedImageModel model) {
    return GeneratedImageEntity(
      created: model.created,
      b64Json: model.b64Json,
    );
  }

  @override
  List<Object?> get props => [created, b64Json];
}
