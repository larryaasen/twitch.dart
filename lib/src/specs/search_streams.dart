import 'package:twitch/src/models/stream.dart' as twitch_api;
import 'package:twitch/src/spec.dart';

class SearchStreamsSpec extends JsonResultsSpec<twitch_api.Stream> {
  const SearchStreamsSpec();

  @override
  twitch_api.Stream decode(Map<String, Object> json) => twitch_api.Stream.fromJson(json);

  @override
  List<Map<String, Object>> items(Map<String, Object> json) {
    return List<Map<String, Object>>.from(json['streams'] as List<dynamic>);
    }
}
