import 'package:intl/intl.dart';

class CustomPropertiesForGroupedListView {
  static const int ALL_TAB = 0;
  static const int TODAY_TAB = 1;
  static const int UPCOMING_TAB = 2;

  static int groupComparator(String value1, String value2, int tabType) {
    switch (tabType) {
      case ALL_TAB:
        {
          return 1;
        }

      case TODAY_TAB:
      case UPCOMING_TAB:
        {
          return value1 == "Overdue" ? 1 : value2.compareTo(value1);
        }
      default:
        {
          return 1;
        }
    }
  }

  static int itemComparator(dynamic value1, dynamic value2, int tabType) {
    switch (tabType) {
      case ALL_TAB:
        {
          return 1;
        }

      case TODAY_TAB:
      case UPCOMING_TAB:
        {
          return value2.dateTime.difference(value1.dateTime).inSeconds;
        }
      default:
        {
          return 1;
        }
    }
  }

  static String groupBy(dynamic element, DateFormat formatter, int tabType) {
    switch (tabType) {
      case ALL_TAB:
        {
          return "";
        }

      case TODAY_TAB:
      case UPCOMING_TAB:
        {
          DateTime today = DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 0, 0, 0);
          DateTime tomorrow = today.add(Duration(days: 1));

          // print("today: ${today.toString()}");
          // print("tomorrow: ${tomorrow.toString()}");

          if (element.dateTime.isBefore(today)) {
            return "Overdue";
          } else {
            if (element.dateTime.isBefore(tomorrow)) {
              return formatter.format(element.dateTime) + " (Today) ";
            } else {
              return formatter.format(element.dateTime);
            }
          }
        }
      default:
        {
          return "";
        }
    }
  }
}
