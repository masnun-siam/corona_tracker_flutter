import 'package:corona_tracker/networking.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final data, globalData;
  const HomePage({Key key, this.data, this.globalData}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var now;
  bool _showSpinner = false;
  String country;
  String countryFlag;
  int confirmedTotal;
  int confirmedToday;
  int recoveredTotal;
  int recoveredToday;
  int deceasedTotal;
  int deceasedToday;
  int confirmedTotalGlobal;
  int confirmedTodayGlobal;
  int recoveredTotalGlobal;
  int recoveredTodayGlobal;
  int deceasedTotalGlobal;
  int deceasedTodayGlobal;

  void updateData(var dataa) {
    setState(() {
      if (dataa != null) {
        country = dataa['country'];
        countryFlag = dataa['countryInfo']['flag'];
        confirmedTotal = dataa['cases'];
        confirmedToday = dataa['todayCases'];
        recoveredTotal = dataa['recovered'];
        recoveredToday = dataa['todayCases'];
        deceasedTotal = dataa['deaths'];
        deceasedToday = dataa['todayDeaths'];
        confirmedTotalGlobal = widget.globalData['cases'];
        confirmedTodayGlobal = widget.globalData['todayCases'];
        recoveredTotalGlobal = widget.globalData['recovered'];
        recoveredTodayGlobal = widget.globalData['todayCases'];
        deceasedTotalGlobal = widget.globalData['deaths'];
        deceasedTodayGlobal = widget.globalData['todayDeaths'];
      } else {
        country = 'Country not found';
        countryFlag = null;
        confirmedTotal = 0;
        confirmedToday = 0;
        recoveredTotal = 0;
        recoveredToday = 0;
        deceasedTotal = 0;
        deceasedToday = 0;
        confirmedTotalGlobal = 0;
        confirmedTodayGlobal = 0;
        recoveredTotalGlobal = 0;
        recoveredTodayGlobal = 0;
        deceasedTotalGlobal = 0;
        deceasedTodayGlobal = 0;
      }
      now = DateTime.now();
    });
  }

  @override
  void initState() {
    super.initState();
    updateData(widget.data);
  }

  String counrtyName;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<String> lists = [
      'Cover your cough',
      'Keep social distance',
      'Stay at home',
      'Wash your hands',
      'Wear face mask',
      'Clean and disinfect'
    ];

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/bg.jpg'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _titleBox(),
                    SizedBox(height: 30.0),
                    CaseBox(
                      confirmedTotal: confirmedTotal,
                      confirmedToday: confirmedToday,
                      recoveredTotal: recoveredTotal,
                      recoveredToday: recoveredToday,
                      deceasedTotal: deceasedTotal,
                      deceasedToday: deceasedToday,
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      'Global Outbreak',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    CaseBox(
                      confirmedTotal: confirmedTotalGlobal,
                      confirmedToday: confirmedTodayGlobal,
                      deceasedTotal: deceasedTotalGlobal,
                      deceasedToday: deceasedTodayGlobal,
                      recoveredTotal: recoveredTotalGlobal,
                      recoveredToday: 0,
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      'Prevention',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List<Widget>.generate(2, (index) {
                            return PreventionItem(
                              lists: lists,
                              index: index,
                            );
                          }),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List<Widget>.generate(2, (index) {
                            return PreventionItem(
                              lists: lists,
                              index: index + 2,
                            );
                          }),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List<Widget>.generate(2, (index) {
                            return PreventionItem(
                              lists: lists,
                              index: index + 4,
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _titleBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Covid-19 Tracker',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        SizedBox(height: 15.0),
        Row(
          children: <Widget>[
            (countryFlag != null)
                ? Image.network(countryFlag, width: 45.0)
                : Icon(Icons.close, color: Colors.red),
            SizedBox(width: 10.0),
            Expanded(
              child: AutoSizeText(
                '$country',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            GestureDetector(
              onTap: () {
                _showBottomSheet();
              },
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.0),
        Text(
          'Date : ${DateFormat("dd MMM, yyyy").format(now)}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              color: Color(0xff757575),
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Input Country Name',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      onChanged: (value) {
                        counrtyName = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 13.0),
                        border: OutlineInputBorder(),
                        hintText: 'Country',
                      ),
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FlatButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        setState(() {
                          _showSpinner = true;
                        });
                        country = counrtyName;
                        var datab = await Networking.getDataLocal(counrtyName);
                        updateData(datab);
                        setState(() {
                          _showSpinner = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.lightBlueAccent,
                        ),
                        child: Text(
                          'Search',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class PreventionItem extends StatelessWidget {
  PreventionItem({
    Key key,
    @required this.lists,
    @required this.index,
  }) : super(key: key);

  final List<String> lists;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('images/$index.png'),
              height: 50.0,
              width: 50.0,
            ),
            AutoSizeText(
              lists[index],
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class CaseBox extends StatelessWidget {
  final int confirmedTotal;
  final int recoveredTotal;
  final int deceasedTotal;
  final int recoveredToday;
  final int deceasedToday;
  final int confirmedToday;

  const CaseBox(
      {Key key,
      this.confirmedTotal,
      this.recoveredTotal,
      this.deceasedTotal,
      this.recoveredToday,
      this.deceasedToday,
      this.confirmedToday})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1.0,
            offset: Offset(1.0, 1.0),
          ),
        ],
      ),
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: _caseSegment(
              color: Colors.blue,
              text: 'Confirmed',
              totalnumber: '$confirmedTotal',
              dailynumber: '$confirmedToday',
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: _caseSegment(
              color: Colors.green,
              text: 'Recovered',
              totalnumber: '$recoveredTotal',
              dailynumber: '',
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: _caseSegment(
              color: Colors.red,
              text: 'Deceased',
              totalnumber: '$deceasedTotal',
              dailynumber: '$deceasedToday',
            ),
          ),
        ],
      ),
    );
  }

  Column _caseSegment(
      {Color color, String text, String totalnumber, String dailynumber}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AutoSizeText(
          text,
          maxLines: 1,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 10.0),
        AutoSizeText(
          '$totalnumber',
          maxLines: 1,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.arrow_upward,
              size: 13.0,
              color: color,
            ),
            AutoSizeText(
              '$dailynumber',
              maxLines: 1,
              style: TextStyle(
                fontSize: 15.0,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
