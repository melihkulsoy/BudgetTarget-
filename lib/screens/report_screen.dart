import 'package:butceappflutter/api/models/ReportData.dart';
import 'package:butceappflutter/api/repositories/expense_repository.dart';
import 'package:butceappflutter/widgets/my_app_bar.dart';
import 'package:butceappflutter/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String selectedReport = 'Günlük';
  String selectedForecastType = 'Haftalık';
  DateTime startDate = DateTime.utc(1, 1, 1);
  DateTime endDate = DateTime.utc(2999, 12, 30);
  List<ReportData> reportData = new List<ReportData>();
  List<ReportData> forecastData = new List<ReportData>();
  ExpenseRepository expenseRepository = new ExpenseRepository();
  List<String> _reports = <String>['Günlük', 'Haftalık', 'Aylık'];
  List<String> _forecastTypes = <String>['Haftalık', 'Aylık'];
  bool loadingForecast = false;
  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime _selectStartDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2022),
        helpText: 'Başlangıç Tarihini Seçiniz',
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        }).then((date) {
      setState(() {
        this.startDate = date;
      });
      print(this.startDate);
    });
  }

  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime _selectEndDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2022),
        helpText: 'Başlangıç Tarihini Seçiniz',
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        }).then((date) {
      setState(() {
        this.endDate = date;
      });
      print(this.endDate);
    });
  }

  getReportData({String reportType, DateTime startDate, DateTime endDate}) {
    this
        .expenseRepository
        .getReportData(
            reportType: reportType, startDate: startDate, endDate: endDate)
        .then((value) {
      setState(() {
        this.reportData = value;
      });
    });
  }

  @override
  void initState() {
    this.getReportData(reportType: 'Günlük');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Rapor ve Tahmin'),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 10),
          SfCartesianChart(
            tooltipBehavior: TooltipBehavior(
              enable: true,
              header: "",
            ),
              primaryXAxis: CategoryAxis(),
              series: <LineSeries<ReportData, String>>[
                LineSeries<ReportData, String>(
                  color: Theme.of(context).primaryColor,
                    // Bind data source
                    dataSource: this.reportData,
                    xValueMapper: (ReportData sales, _) => sales.date,
                    yValueMapper: (ReportData sales, _) => sales.value),
              ]),
          SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                onChanged: (value) {
                  setState(() {
                    this.selectedReport = value;
                    this.getReportData(
                        reportType: value,
                        startDate: startDate,
                        endDate: endDate);
                  });
                },
                hint: Text('Kategori'),
                value: selectedReport,
                items: _reports.map((report) {
                  return DropdownMenuItem(
                    child: new Text(report),
                    value: report,
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                child: Text('Başlangıç Tarihi'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  setState(() {
                    this._selectStartDate(context).then((value) {
                      this.getReportData(
                          reportType: selectedReport,
                          startDate: startDate,
                          endDate: endDate);
                    });
                  });
                },
              ),
              SizedBox(
                width: 25,
              ),
              RaisedButton(
                child: Text('Bitiş Tarihi'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  setState(() {
                    this._selectEndDate(context).then((value) {
                      this.getReportData(
                          reportType: selectedReport,
                          startDate: startDate,
                          endDate: endDate);
                    });
                  });
                },
              ),
              SizedBox(
                width: 25,
              ),
              RaisedButton(
                child: Text('Reset'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  setState(() {
                    this.startDate = DateTime.utc(1, 1, 1);
                    this.endDate = DateTime.utc(9000, 1, 1);
                    this.getReportData(
                        reportType: selectedReport,
                        startDate: startDate,
                        endDate: endDate);
                  });
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Divider(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: DropdownButton(
                  onChanged: (value) {
                    selectedForecastType = value;
                  },
                  hint:  Text('Tahmin'),
                  value: selectedForecastType,
                  items: _forecastTypes.map((report) {
                    return DropdownMenuItem(
                      child: new Text(report),
                      value: report,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(width: 25),
              Center(
                child: RaisedButton(
                  child: !loadingForecast ? Text('Tahmin Hesapla') : Text('Hesaplanıyor..'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).accentColor,
                  onPressed: !loadingForecast ? () {
                    setState(() {
                      this.loadingForecast = true;
                    });
                    this.expenseRepository.forecast(
                      first: selectedReport,
                      second: selectedForecastType,
                      expenses: this.reportData,
                      ).then((value) {
                        print(value);
                        setState(() {
                        this.loadingForecast = false;
                        this.forecastData = value;
                        showGeneralDialog(
                          context: context,
                          barrierColor: Colors.white.withOpacity(1), // background color
                          barrierDismissible: false, // should dialog be dismissed when tapped outside
                          barrierLabel: "Dialog", // label for barrier
                          transitionDuration: Duration(milliseconds: 400), // how long it takes to popup dialog after button click
                          pageBuilder: (_, __, ___) { // your widget implementation 
                            return SizedBox.expand( // makes widget fullscreen
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox.expand(
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: SfCartesianChart(
                                    tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                      header: "",
                                    ),
                                      primaryXAxis: CategoryAxis(),
                                      series: <LineSeries<ReportData, String>>[
                                        LineSeries<ReportData, String>(
                                          color: Theme.of(context).primaryColor,
                                            // Bind data source
                                            dataSource: this.reportData,
                                            xValueMapper: (ReportData sales, _) => sales.date,
                                            yValueMapper: (ReportData sales, _) => sales.value),
                                        LineSeries<ReportData, String>(
                                          color: Colors.red,
                                            // Bind data source
                                            dataSource: this.forecastData,
                                            xValueMapper: (ReportData sales, _) => sales.date,
                                            yValueMapper: (ReportData sales, _) => sales.value),
                                      ])
                                    ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox.expand(
                                      child: RaisedButton(
                                        color: Theme.of(context).primaryColor,
                                        child: Text(
                                          "Geri Dön",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Theme.of(context).accentColor
                                            ),
                                        ),
                                        textColor: Colors.white,
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        });
                        });
                  } : null,
                ),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}