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

  Tracker.from(Tracker other) {
    id = other.id;
    name = other.name;
    successes = other.successes;
    failures = other.failures;
  }

  Tracker copyWith({ int successes = -1, int failures = -1 }) {
    var tracker = new Tracker.from(this);
    
    if (successes != -1) {
      tracker.successes = successes;
    }
    if (failures != -1) {
      tracker.failures = failures;
    }

    return tracker;
  }

  int getSuccessRate() {
    if (failures == 0) {
      return 0;
    }

    return ((successes / (successes + failures)) * 100).toInt();
  }

  static Tracker fromJson(Map<String, Object> json) {
    final tracker = new Tracker(
      json["name"] as String,
      successes: json["successes"] as int,
      failures: json["failures"] as int,
    );
    tracker.id = json["id"] as String;

    return tracker;
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "name": name,
      "successes": successes,
      "failures": failures,
    };
  }
}
