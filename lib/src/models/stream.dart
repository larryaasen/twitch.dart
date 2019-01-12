import 'package:meta/meta.dart';
import 'package:twitch/src/models/channel.dart';
import 'package:twitch/src/models/twitch_cdn_image.dart';

/// A basic Stream model
///
/// * [API Reference](https://dev.twitch.tv/docs/v5/reference/streams/).
@immutable
class Stream {
  final int id;
  final String game;
  final int viewers;
  final int videoHeight;
  final double averageFPS;
  final int delay;
  final DateTime createdAt;
  final bool isPlaylist;
  final String streamType;
  final TwitchCdnImage preview;
  final Channel channel;

  const Stream({
    @required this.id,
    @required this.game,
    @required this.viewers,
    @required this.videoHeight,
    @required this.averageFPS,
    @required this.delay,
    @required this.createdAt,
    @required this.isPlaylist,
    @required this.streamType,
    @required this.preview,
    @required this.channel,
  });

  static Stream fromJson(Map<String, Object> json) {
    return json == null ? null : Stream(
      id: json['_id'] as int,
      game: json['game'] as String,
      viewers: json['viewers'] as int,
      videoHeight: json['video_height'] as int,
      averageFPS: json['average_fps'] as double,
      delay: json['delay'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      isPlaylist: json['is_playlist'] as bool,
      streamType: json['stream_type'] as String,
      preview: TwitchCdnImage.fromJson(json['preview'] as Map<String, Object>),
      channel: Channel.fromJson(json['channel'] as Map<String, Object>),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stream &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          game == other.game &&
          viewers == other.viewers &&
          videoHeight == other.videoHeight &&
          averageFPS == other.averageFPS &&
          delay == other.delay &&
          createdAt == other.createdAt &&
          isPlaylist == other.isPlaylist &&
          streamType == other.streamType &&
          preview == other.preview &&
          channel == other.channel;

  @override
  int get hashCode =>
      id.hashCode ^
      game.hashCode ^
      viewers.hashCode ^
      videoHeight.hashCode ^
      averageFPS.hashCode ^
      delay.hashCode ^
      createdAt.hashCode ^
      isPlaylist.hashCode ^
      streamType.hashCode ^
      preview.hashCode ^
      channel.hashCode;

  @override
  String toString() {
    return 'StreamTitch{id: $id, name: $game, viewers: $viewers, streamType: $streamType}';
  }
}
