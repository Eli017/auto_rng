
enum TimeDenominatorType {
  hour,
  minute,
  second
}

int convertSecondsToMilliseconds(int seconds) {
  return seconds * 1000;
}

int convertMinutesToMilliseconds(int minutes) {
  return minutes * 60000;
}

int convertTimePerDuration(int time, TimeDenominatorType denominatorType) {
  if (time == 0) {
    return 0;
  }
  int denominatorInMilliseconds;
  switch (denominatorType) {
    case TimeDenominatorType.second: {
      denominatorInMilliseconds = 1000;
      break;
    }
    case TimeDenominatorType.minute:
      denominatorInMilliseconds = 60000;
      break;
    case TimeDenominatorType.hour:
      denominatorInMilliseconds = 3600000;
      break;
  }
  return (denominatorInMilliseconds/time).round();
}