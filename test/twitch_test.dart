// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn('vm')
import 'package:test/test.dart';
import 'package:twitch/src/models/stream.dart' as twitch_api;
import 'package:twitch/src/models/video.dart';
import 'package:twitch/twitch.dart';

import 'common.dart';

void main() {
  final http = new FakeTwitchHttp({
    'https://fake.api.twitch.tv/games/top?': jsonFile('games_top'),
    'https://fake.api.twitch.tv/videos/top?': jsonFile('videos_top'),
    'https://fake.api.twitch.tv/search/channels?query=hi':
        jsonFile('search_channels'),
    'https://fake.api.twitch.tv/search/games?query=hi':
        jsonFile('search_games'),
    'https://fake.api.twitch.tv/channels/26991127/videos?':
        jsonFile('channels_26991127_videos'),
    'https://fake.api.twitch.tv/streams?': jsonFile('search_streams'),
    'https://fake.api.twitch.tv/streams/22510310?api_version=5': jsonFile('streams_19571641'),
  });

  final twitch = new Twitch(http);

  test('should fetch the top games', () async {
    final topGames = await twitch.getTopGames();
    expect(topGames, const TypeMatcher<Response<TopGame>>());
    expect(topGames, hasLength(1));

    final counterStrike = topGames.first;
    expect(counterStrike.channels, 953);
    expect(counterStrike.viewers, 171708);

    final game = counterStrike.game;
    expect(game.name, 'Counter-Strike: Global Offensive');
    expect(game.popularity, 170487);
    expect(game.id, 32399);

    final logo = game.logo;
    expect(logo.large, endsWith('240x144.jpg'));
    expect(logo.medium, endsWith('120x72.jpg'));
    expect(logo.small, endsWith('60x36.jpg'));
    expect(logo.custom(width: 100, height: 100), endsWith('100x100.jpg'));
  });

  test('should fetch the top videos', () async {
    final topVideos = await twitch.getTopVideos();
    expect(topVideos, const TypeMatcher<Response<Video>>());
    expect(topVideos, hasLength(1));

    final topVideo = topVideos.first;
    expect(topVideo.id, "v140675974");
    expect(topVideo.description, "www.bayriffer.net");
    expect(topVideo.game, "Resident Evil 6");
    expect(topVideo.title, "Resident Evil 6 : Leon Chapter 1");
    expect(topVideo.url, "https://www.twitch.tv/videos/140675974");

    final preview = topVideo.preview;
    expect(preview.large, endsWith('640x360.png'));
    expect(preview.medium, endsWith('320x180.png'));
    expect(preview.small, endsWith('80x45.png'));
    expect(preview.custom(width: 100, height: 100), endsWith('100x100.png'));

    final channel = topVideo.channel;
    expect(channel.id, 110928620);
    expect(channel.name, "bayriffer");
  });

  test('should search for channels', () async {
    final channels = await twitch.searchChannels("hi");
    expect(channels, const TypeMatcher<Response<Channel>>());
    expect(channels, hasLength(1));
    expect(channels.total, 388015);

    final channel = channels.first;
    expect(channel.mature, false);
    expect(channel.status,
        "hi!  |  http://www.designbyhumans.com/shop/hiko Follow @Hiko");
    expect(channel.broadcasterLanguage, "en");
    expect(channel.displayName, "Hiko");
    expect(channel.game, "Counter-Strike: Global Offensive");
    expect(channel.language, "en");
    expect(channel.id, 26991127);
    expect(channel.name, "hiko");
    expect(channel.createdAt, DateTime.parse("2011-12-23T17:36:09.142428Z"));
    expect(channel.updatedAt, DateTime.parse("2017-06-04T10:00:39.496137Z"));
    expect(channel.partner, false);
    expect(channel.logo,
        "https://static-cdn.jtvnw.net/jtv_user_pictures/hiko-profile_image-fa9474314cb6cafa-300x300.png");
    expect(channel.videoBanner,
        "https://static-cdn.jtvnw.net/jtv_user_pictures/hiko-channel_offline_image-269c30cc6d860b5c-1920x1080.png");
    expect(channel.profileBanner,
        "https://static-cdn.jtvnw.net/jtv_user_pictures/hiko-profile_banner-5deef30f2102cc79-480.png");
    expect(channel.profileBannerBackgroundColor, "");
    expect(channel.url, "https://www.twitch.tv/hiko");
    expect(channel.views, 15651912);
    expect(channel.followers, 484139);
    expect(channel.broadcasterType, "");
    expect(channel.description,
        "Average Gamer. CSGO Partnerships @ Twitch . Twitter @Hiko");
  });

  test('should search for games', () async {
    final games = await twitch.searchGames("hi");
    expect(games, const TypeMatcher<Response<Game>>());
    expect(games, hasLength(1));

    final game = games.first;
    expect(game.name, "HITMAN");
    expect(game.popularity, 18);
    expect(game.id, 491471);

    final box = game.box;
    expect(box.large, endsWith('272x380.jpg'));
    expect(box.medium, endsWith('136x190.jpg'));
    expect(box.small, endsWith('52x72.jpg'));
    expect(box.custom(width: 100, height: 100), endsWith('100x100.jpg'));

    final logo = game.logo;
    expect(logo.large, endsWith('240x144.jpg'));
    expect(logo.medium, endsWith('120x72.jpg'));
    expect(logo.small, endsWith('60x36.jpg'));
    expect(logo.custom(width: 100, height: 100), endsWith('100x100.jpg'));
  });

  test('should fetch videos for a given channel', () async {
    final videos = await twitch.getChannelVideos(26991127);
    expect(videos is Response<Video>, true);
    expect(videos, hasLength(1));

    expect(videos.first.id, "v147067595");
  });

  test('should fetch the top streams', () async {
    final streams = await twitch.searchStreams();
    expect(streams, const TypeMatcher<Response<twitch_api.Stream>>());
    expect(streams, hasLength(1));

    final stream = streams.first;
    expect(stream.id, 32046079040);
    expect(stream.game, "Castlevania Chronicles");
    expect(stream.viewers, 137399);
    expect(stream.videoHeight, 1080);
    expect(stream.averageFPS, 60.0169061708);
    expect(stream.delay, 0);
    expect(stream.createdAt, DateTime.parse("2019-01-06T16:08:41Z"));
    expect(stream.isPlaylist, false);
    expect(stream.streamType, 'live');
    expect(stream.preview, isNotNull);
    expect(stream.channel, isNotNull);

    final preview = stream.preview;
    expect(preview.large, endsWith('640x360.jpg'));
    expect(preview.medium, endsWith('320x180.jpg'));
    expect(preview.small, endsWith('80x45.jpg'));
    expect(preview.custom(width: 100, height: 100), endsWith('100x100.jpg'));

    final channel = stream.channel;
    expect(channel.mature, false);
    expect(channel.status,
        "AGDQ 2019 benefiting Prevent Cancer Foundation - Castlevania Chronicles");
    expect(channel.broadcasterLanguage, "en");
    expect(channel.displayName, "GamesDoneQuick");
    expect(channel.game, "Castlevania Chronicles");
    expect(channel.language, "en");
    expect(channel.id, 22510310);
    expect(channel.name, "gamesdonequick");
    expect(channel.createdAt, DateTime.parse("2011-05-20T18:19:19Z"));
    expect(channel.updatedAt, DateTime.parse("2019-01-07T20:08:07Z"));
    expect(channel.partner, true);
    expect(channel.logo,
        "https://static-cdn.jtvnw.net/jtv_user_pictures/b3fc1f16-0818-4121-8711-c31b9469bc21-profile_image-300x300.png");
    expect(channel.videoBanner,
        "https://static-cdn.jtvnw.net/jtv_user_pictures/7e682fac-b48d-4c42-a959-3beabc1954be-channel_offline_image-1920x1080.png");
    expect(channel.profileBanner,
        "https://static-cdn.jtvnw.net/jtv_user_pictures/81f165a6-520e-4f63-9188-3454c59ff6fa-profile_banner-480.png");
    expect(channel.profileBannerBackgroundColor, "");
    expect(channel.url, "https://www.twitch.tv/gamesdonequick");
    expect(channel.views, 215228454);
    expect(channel.followers, 1399459);
  });

  test('should fetch the stream', () async {
    final stream = await twitch.getStreamByUser(22510310);
    expect(stream, const TypeMatcher<twitch_api.Stream>());
    expect(stream.id, 32093303680);
  });
}
