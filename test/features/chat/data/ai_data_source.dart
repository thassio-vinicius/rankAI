import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rankai/core/http/client.dart';
import 'package:rankai/features/chat/data/data_source/ai_data_source.dart';
import 'package:rankai/features/chat/data/models/completions/message_model.dart';

class MockHTTP extends Mock implements HTTP {}

void main() {
  late AIDataSourceImpl dataSource;
  late MockHTTP mockHTTP;

  setUp(() {
    mockHTTP = MockHTTP();
    dataSource = AIDataSourceImpl(mockHTTP);
  });

  group('AIDataSourceImpl', () {
    const prompt = 'Test prompt';
    final messageModel =
        MessageModel(content: 'Test message', role: 'test_role');

    test('fetchRankings throws error on failure', () async {
      when(() => mockHTTP.client.post(any(), data: any(named: 'data')))
          .thenThrow(Exception());

      expect(() => dataSource.fetchRankings([messageModel]), throwsException);
    });

    test('generateImages throws error on failure', () async {
      when(() => mockHTTP.client.post(any(), data: any(named: 'data')))
          .thenThrow(Exception());

      expect(() => dataSource.generateImages(prompt), throwsException);
    });
  });
}
