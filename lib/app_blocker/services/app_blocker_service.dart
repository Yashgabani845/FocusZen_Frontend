import 'package:app_usage/app_usage.dart';

class AppBlockerService {
  Future<List<AppUsageInfo>> fetchAppUsage() async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(const Duration(hours: 24));
    
    // Note: This relies on Native Android Channels which will throw exceptions 
    // on unsupported platforms or if permissions are absent. Let the caller handle it.
    List<AppUsageInfo> infoList = await AppUsage().getAppUsage(startDate, endDate);
    
    // Sort by usage time descending
    infoList.sort((a, b) => b.usage.inSeconds.compareTo(a.usage.inSeconds));
    
    // Filter out zero usage or extremely low usage
    return infoList.where((info) => info.usage.inMinutes > 0).toList();
  }
}
