import 'package:excelapp/Models/schedule_model.dart';
import 'package:excelapp/UI/Themes/colors.dart';
import 'package:excelapp/UI/Themes/gradient.dart';
import 'package:excelapp/UI/constants.dart';
import 'package:flutter/material.dart';
import 'package:excelapp/UI/Screens/Schedule/Widgets/generateScheduleCardList.dart';

class SchedulePage extends StatelessWidget {
  final scheduleData;
  SchedulePage({@required this.scheduleData});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // length: 4,
      length: 3,
      child: new Scaffold(
        body: new NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                title: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                    child: Text(
                      "Event Schedule",
                      style: TextStyle(
                          color: white100,
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                  ),
                ),
                backgroundColor: Color(0xFF000000),
                floating: true,
                pinned: true,
                snap: true,
                bottom: new TabBar(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  indicatorColor: primaryPink,
                  dividerColor: Colors.black,
                  labelColor: primaryPink,
                  unselectedLabelColor: secondaryColor,
                  tabs: [
                    // dayTab('Oct-Nov', 'Pre Events'),
                    dayTab('Jan 24', 'Day 1'),
                    dayTab('Jan 25', 'Day 2'),
                    dayTab('Jan 26', 'Day 3'),
                  ],
                ),
              ),
            ];
          },
          body: Container(
            decoration: BoxDecoration(
              gradient: primaryGradient(),
            ),
            child: new TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                schedule(0),
                schedule(1),
                schedule(2),
                // schedule(3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dayTab(date, day) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            date,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
          Text(
            day,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }

  Widget schedule(dayNumber) {
    List<ScheduleModel> day0 = scheduleData["day1"];
    day0.sort((a, b) =>
        DateTime.parse(a.datetime).compareTo(DateTime.parse(b.datetime)));
    List<ScheduleModel> day1 = scheduleData["day2"];
    day1.sort((a, b) =>
        DateTime.parse(a.datetime).compareTo(DateTime.parse(b.datetime)));
    List<ScheduleModel> day2 = scheduleData["day3"];
    day2.sort((a, b) =>
        DateTime.parse(a.datetime).compareTo(DateTime.parse(b.datetime)));

    Widget returnWidget = Container(); // Default value

    if (dayNumber == 0)
      returnWidget = TimeTableList(day0);
    else if (dayNumber == 1)
      returnWidget = TimeTableList(day1);
    else if (dayNumber == 2) returnWidget = TimeTableList(day2);
    // else if (dayNumber == 3) returnWidget = TimeTableList(day3);

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: returnWidget,
    );
  }
}
