import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  final chartData;
  LineChartSample2({@required this.chartData});
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    // print(widget.chartData[23]['values'][5]["value"]);
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3, //TODO: long setup
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              // color: Color(0xff232d37),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 0.0, left: 0.0, top: 10, bottom: 2),
              child: LineChart(
                showAvg ? avgData() : mainData(),
              ),
            ),
          ),
        ),
        // SizedBox(
        //   width: 60,
        //   height: 34,
        //   child: FlatButton(
        //     onPressed: () {
        //       setState(() {
        //         showAvg = !showAvg;
        //       });
        //     },
        //     child: Text(
        //       'avg',
        //       style: TextStyle(
        //         fontSize: 12,
        //         color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            // color: const Color(0xff37434d),
            color: Colors.yellow,
            // color: ,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            // color: const Color(0xff37434d),
            color: Colors.red,
            strokeWidth: 1,
          );
        },
      ),
      lineTouchData: LineTouchData(
        fullHeightTouchLine: false,
        enabled: true,
        // getTouchedSpotIndicator: (barData, spotIndexes) => '',
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Theme.of(context).primaryColor,
          fitInsideHorizontally: true,
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            // print(touchedSpots[0].barIndex);
            // return [];
            if (touchedSpots == null) {
              return null;
            }

            return touchedSpots.map((LineBarSpot touchedSpot) {
              if (touchedSpot == null) {
                return null;
              }
              final TextStyle textStyle = TextStyle(
                color: Theme.of(context).textTheme.headline5.color,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              );
              return LineTooltipItem(
                  touchedSpot.y.toString() + '°C', textStyle);
            }).toList();
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyText2.color,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          getTitles: (value) {
            if (value.toInt() % 2 == 1 && value.toInt() != 23) {
              return time(
                  stime: widget.chartData[value.toInt()]['tillDateTime']
                      .toString());
            } else if (value.toInt() == 23) {
              return time(
                  stime: widget.chartData[value.toInt()]['tillDateTime']
                      .toString(),
                  full: false);
            } else {
              return '';
            }
            // switch (value.toInt()) {
            //   case 2:
            //     return '-22h';
            //   case 5:
            //     return '-19h';
            //   case 8:
            //     return '-16h';
            //   case 15:
            //     return '-9h';
            //   case 20:
            //     return '-4h';
            //   case 23:
            //     return time(widget.chartData[23]['tillDateTime'].toString());
            // }
          },
          margin: 5,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 23,
      // minY: 0,
      // maxY: 30,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, widget.chartData[0]['values'][5]["value"]),
            FlSpot(1, widget.chartData[1]['values'][5]["value"]),
            FlSpot(2, widget.chartData[2]['values'][5]["value"]),
            FlSpot(3, widget.chartData[3]['values'][5]["value"]),
            FlSpot(4, widget.chartData[4]['values'][5]["value"]),
            FlSpot(5, widget.chartData[5]['values'][5]["value"]),
            FlSpot(6, widget.chartData[6]['values'][5]["value"]),
            FlSpot(7, widget.chartData[7]['values'][5]["value"]),
            FlSpot(8, widget.chartData[8]['values'][5]["value"]),
            FlSpot(9, widget.chartData[9]['values'][5]["value"]),
            FlSpot(10, widget.chartData[10]['values'][5]["value"]),
            FlSpot(11, widget.chartData[11]['values'][5]["value"]),
            FlSpot(12, widget.chartData[12]['values'][5]["value"]),
            FlSpot(13, widget.chartData[13]['values'][5]["value"]),
            FlSpot(14, widget.chartData[14]['values'][5]["value"]),
            FlSpot(15, widget.chartData[15]['values'][5]["value"]),
            FlSpot(16, widget.chartData[16]['values'][5]["value"]),
            FlSpot(17, widget.chartData[17]['values'][5]["value"]),
            FlSpot(18, widget.chartData[18]['values'][5]["value"]),
            FlSpot(19, widget.chartData[19]['values'][5]["value"]),
            FlSpot(20, widget.chartData[20]['values'][5]["value"]),
            FlSpot(21, widget.chartData[21]['values'][5]["value"]),
            FlSpot(22, widget.chartData[22]['values'][5]["value"]),
            FlSpot(23, widget.chartData[23]['values'][5]["value"]),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  String time({String stime, bool full = false}) {
    int h = int.parse(
            stime.substring(stime.indexOf("T") + 1, stime.indexOf("T") + 3)) +
        2;
    String minute =
        stime.substring(stime.indexOf("T") + 4, stime.indexOf("T") + 6);
    String hour = h >= 24 ? (h - 24).toString() : h.toString();
    // return '$hour:$minute';
    return full ? '$hour:$minute' : hour;
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
