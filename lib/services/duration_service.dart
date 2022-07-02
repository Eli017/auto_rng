import 'package:shared_preferences/shared_preferences.dart';

enum DurationType {
  traditional,
  unique,
}

class DurationService {
  void setDurationType(DurationType type) async {
    SharedPreferences durationPref = await SharedPreferences.getInstance();
    durationPref.setString('duration_type', type.name);
  }

  Future<DurationType> getDurationType() async {
    SharedPreferences durationPref = await SharedPreferences.getInstance();
    String? durationString = durationPref.getString('duration_type');
    DurationType durationSaved = DurationType.values.byName(durationString ?? 'traditional');
    return durationSaved;
  }
}