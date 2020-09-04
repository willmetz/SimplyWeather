import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CustomCacheManager extends BaseCacheManager {
  static const key = "customCache";

  static Map<Duration, CustomCacheManager> _instanceMap = new Map();

  factory CustomCacheManager(Duration cacheDuration) {
    if (!_instanceMap.containsKey(cacheDuration)) {
      _instanceMap[cacheDuration] = new CustomCacheManager._(cacheDuration);
    }
    return _instanceMap[cacheDuration];
  }

  CustomCacheManager._(Duration cacheDuration) : super(key, maxAgeCacheObject: cacheDuration, maxNrOfCacheObjects: 100);

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return path.join(directory.path, key);
  }
}
