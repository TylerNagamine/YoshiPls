/// A function to edit a tracker.
typedef void EditTracker(int success, int failure);

/// A function definition which accepts a tracker as its only param.
typedef void TrackerFunction(Tracker tracker);

/// A class which tracks success and failures.
class Tracker {
  String id;
  String name;
  int successes;
  int failures;

  Tracker(this.name, { this.successes = 0, this.failures = 0 });

  int getSuccessRate() {
    if (failures == 0) {
      return 0;
    }

    return ((successes / (successes + failures)) * 100).toInt();
  }
}
