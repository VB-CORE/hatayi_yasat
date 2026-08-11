import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/hive_cache.dart';
import 'package:lifeclient/product/feature/cache/hive_v2/model/news_bookmark_cache.dart';
import 'package:lifeclient/product/feature/cache/product_cache.dart';

void main() {
  late Directory dir;
  late ProductCache cache;

  setUpAll(() async {
    dir = Directory.systemTemp.createTempSync('product_cache_test');
    cache = ProductCache(cacheManager: HiveCacheManager(path: dir.path));
    await cache.init();
  });

  tearDownAll(() async {
    await Hive.close();
    dir.deleteSync(recursive: true);
  });

  test('boxes are usable as soon as init() completes', () {
    cache.newsBookmarkCache.add(
      const NewsBookmarkCache(newsId: 'news-1', title: 'a'),
    );

    expect(cache.newsBookmarkCache.getAll(), hasLength(1));
    expect(cache.newsBookmarkCache.get('news-1'), isNotNull);
  });
}
