import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voyager/base/models/reward/air_reward/air_rewards.dart';
import 'package:voyager/theme/theme.dart' as THEME;

class FlightVoucher extends StatefulWidget {
  @override
  _FlightVoucherState createState() => _FlightVoucherState();
}

class _FlightVoucherState extends State<FlightVoucher> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String radioValue = 'One Way';
  String airReward = 'SAA Awards';
  String awardName = 'SAA Awards';
  String awardType = 'Upgrade Awards';
  String regionTravel = 'Travel within South African cities';
  String cabinClass = 'Business';
  String airRewardName = 'SAA Awards';
  String searchType = 'One Way';
  List<String> airPartners = <String>["SAA Awards", "StarAllianceAwards"];
  List<String> airRewardsNames = List<String>();
  List<String> saaAwardNames = List<String>();
  List<String> starAllianceAwardNames = List<String>();
  List<String> saaAwardTypes = List<String>();
  List<String> starAwardTypes = List<String>();
  List<String> commonAwardNames = List<String>();
  List<String> regionTravells = List<String>();
  List<String> saaCabinClasses = List<String>();
  List<String> starCabinClasses = List<String>();
  List<String> commonCabinClasses = List<String>();
  List<String> saaSearchTypes = List<String>();
  List<String> starSearchTypes = List<String>();
  List<String> commonSearchType = List<String>();
  bool isSubmitted = false;
  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    createFlightVoucher();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(THEME.PRIMARY_COLOR),
        title: Text('Create Voucher'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              //notifictn pg
            },
            child: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/plainbackground.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: new Form(
            key: _formKey,
            autovalidate: true,
            child: new ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'SAA, SA Express & Airlink Award',
                      ),
                      isEmpty: airReward == '',
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          value: airReward,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              //newContact.favoriteColor = newValue;
                              airReward = newValue;
                              checkAirRewards(airReward);
                              state.didChange(newValue);
                            });
                          },
                          items: airPartners.map((String value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        //icon: const Icon(Icons.color_lens),
                        labelText: 'Select Award Name',
                      ),
                      isEmpty: awardName == '',
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          value: awardName,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              //newContact.favoriteColor = newValue;
                              awardName = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: commonAwardNames.map((String value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        //icon: const Icon(Icons.color_lens),
                        labelText: 'Select Award Type',
                      ),
                      isEmpty: awardType == '',
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          value: awardType,
                          isDense: true,
                          onChanged: (String aType) {
                            setState(() {
                              //newContact.favoriteColor = newValue;
                              awardType = aType;
                              state.didChange(aType);
                            });
                          },
                          items: saaAwardTypes.map((String value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        //icon: const Icon(Icons.color_lens),
                        labelText: 'Select Search Types',
                      ),
                      isEmpty: searchType == '',
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          value: searchType,
                          isDense: true,
                          onChanged: (String sType) {
                            setState(() {
                              //newContact.favoriteColor = newValue;
                              searchType = sType;
                              state.didChange(sType);
                            });
                          },
                          items: commonSearchType.map((String value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: radioValue,
                      groupValue: radioValue,
                      onChanged: (String val) {
                        print(val);
                        setState(() {
                          radioValue = null;
                        });
                      },
                    ),
                    Text(searchType),
                  ],
                ),
                FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        //icon: const Icon(Icons.color_lens),
                        labelText: 'Select Region Of Travel',
                      ),
                      isEmpty: regionTravel == '',
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          value: regionTravel,
                          isDense: true,
                          onChanged: (String region) {
                            setState(() {
                              //newContact.favoriteColor = newValue;
                              regionTravel = region;
                              state.didChange(region);
                            });
                          },
                          items: regionTravells.map((String value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        //icon: const Icon(Icons.color_lens),
                        labelText: 'Select Cabin Class',
                      ),
                      isEmpty: cabinClass == '',
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          value: cabinClass,
                          isDense: true,
                          onChanged: (String region) {
                            setState(() {
                              //newContact.favoriteColor = newValue;
                              cabinClass = region;
                              state.didChange(region);
                            });
                          },
                          items: commonCabinClasses.map((String value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        //icon: const Icon(Icons.color_lens),
                        labelText: 'Select Reward Name',
                      ),
                      isEmpty: airRewardName == '',
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          value: airRewardName,
                          isDense: true,
                          onChanged: (String region) {
                            setState(() {
                              //newContact.favoriteColor = newValue;
                              airRewardName = region;
                              state.didChange(region);
                            });
                          },
                          items: airRewardsNames.map((String value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Nominated Traveller',
                    labelText: 'Nominated Traveller',
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        //toggleCheckbox(value);
                        setState(() {
                          print(value);
                          isChecked = value;
                        });
                      },
                      activeColor: Color(THEME.PRIMARY_COLOR),
                      checkColor: Colors.white,
                      tristate: false,
                    ),
                  ),
                  Text('The information provided above is correct')
                ]),
                SizedBox(
                  height: 5,
                ),
                Container(
                  //padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  padding: EdgeInsets.only(left: 0, right: 1),
                  //alignment: Alignment(2.0, 10.0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      inkWellSection(
                          "Term and Condition", '/termsandconditions'),
                      inkWellSection("Make a Booking", '/makeabooking'),
                      //makeaBookingSection()
                      //Text('Term and Condition')
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                new Container(
                  //padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                  //width: MediaQuery.of(context).size.width,
                    height: 45.0,
                    //padding: EdgeInsets.only(left: 20, right: 15, top: 20),
                    child: new RaisedButton(
                      textColor: Colors.white,
                      elevation: 0.0,
                      color: Color(THEME.BUTTON_COLOR),
                      //child: Text("SIGN IN", style: TextStyle(color: Colors.black)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: const Text('SUBMIT',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {},
                    )),
              ],
            )),
      ),
    );
  }

  InkWell inkWellSection(String title, String path) {
    return InkWell(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 15,
            color: Colors.indigo[900],
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline),
      ),
      onTap: () => Navigator.pushNamed(context, path),
    );
  }

  Future<void> createFlightVoucher() async {
    String jsonData =
        "{\"airRewards\":{\"saaAwards\":[{\"awards\":[{\"awardName\":\"SAA Awards\",\"code\":\"1\"}],\"awardTypes\":[{\"awardName\":\"Upgrade Awards\",\"code\":\"U\"}],\"searchType\":[\"One Way\"],\"regions\":[{\"regionOfTravel\":\"Travel within or between South Africa and Southern African cities\",\"origin\":\"1\",\"destination\":\"1A\"},{\"regionOfTravel\":\"Travel between Africa and North America.\",\"origin\":\"2A\",\"destination\":\"55\"},{\"regionOfTravel\":\"Travel between Southern Africa and Africa\",\"origin\":\"1A\",\"destination\":\"2A\"},{\"regionOfTravel\":\"Travel between Southern Africa and Australia.\",\"origin\":\"1A\",\"destination\":\"4\"},{\"regionOfTravel\":\"Travel between Southern Africa and Central Asia.\",\"origin\":\"1A\",\"destination\":\"90\"},{\"regionOfTravel\":\"Travel between Southern Africa and Europe.\",\"origin\":\"1A\",\"destination\":\"3\"},{\"regionOfTravel\":\"Travel between Southern Africa and Middle East\",\"origin\":\"1A\",\"destination\":\"93\"},{\"regionOfTravel\":\"Travel between Southern Africa and North America.\",\"origin\":\"1A\",\"destination\":\"8\"},{\"regionOfTravel\":\"Travel between Southern Africa and North and South Asia\",\"origin\":\"1A\",\"destination\":\"92\"},{\"regionOfTravel\":\"Travel between Southern Africa and South America.\",\"origin\":\"1A\",\"destination\":\"91\"}],\"cabinClass\":[{\"cabinType\":\"Business\",\"code\":\"E\"}]},{\"awards\":[{\"awardName\":\"SA Airlink\",\"code\":\"2\"}],\"awardTypes\":[{\"awardName\":\"Anyday\",\"code\":\"AD\"},{\"awardName\":\"MileageKeeper\",\"code\":\"MK\"}],\"searchType\":[\"One Way\",\"Round Trip\"],\"regions\":[{\"regionOfTravel\":\"Travel within South African cities\",\"origin\":\"4Z1\",\"destination\":\"4Z1\"},{\"regionOfTravel\":\"Travel between South Africa and Africa 1\",\"origin\":\"4Z2\",\"destination\":\"4Z2\"},{\"regionOfTravel\":\"Travel between South Africa and Southern Africa\",\"origin\":\"4Z1A\",\"destination\":\"4Z1A\"}],\"cabinClass\":[{\"cabinType\":\"Economy\",\"code\":\"Y\"}]},{\"awards\":[{\"awardName\":\"SA Express\",\"code\":\"3\"}],\"awardTypes\":[{\"awardName\":\"K-Keeper\",\"code\":\"AD\"},{\"awardName\":\"MileageKeeper\",\"code\":\"MK\"}],\"searchType\":[\"One Way\",\"Round Trip\"],\"regions\":[{\"regionOfTravel\":\"Travel within South African cities\",\"origin\":\"SX1\",\"destination\":\"SX1\"},{\"regionOfTravel\":\"Travel between South Africa and Africa 1\",\"origin\":\"SX2\",\"destination\":\"SX2\"},{\"regionOfTravel\":\"Travel between South Africa and Southern Africa\",\"origin\":\"SX1A\",\"destination\":\"SX1A\"}],\"cabinClass\":[{\"cabinType\":\"Economy\",\"code\":\"Y\"}]}],\"starAllianceAwards\":{\"awards\":[{\"awardName\":\"Star Alliance Awards\",\"code\":\"STAR\"}],\"searchType\":[\"Round Trip\"],\"origin\":[{\"region\":\"Southern Africa\",\"code\":\"A\"},{\"region\":\"Africa\",\"code\":\"B\"},{\"region\":\"Australia and New Zealand\",\"code\":\"F\"},{\"region\":\"Central America\/Caribbean and Hawaii\",\"code\":\"J\"},{\"region\":\"Central Asia\",\"code\":\"H\"},{\"region\":\"Europe\",\"code\":\"C\"},{\"region\":\"Middle East\",\"code\":\"D\"},{\"region\":\"North America\",\"code\":\"I\"},{\"region\":\"North and South Asia\",\"code\":\"G\"},{\"region\":\"South America\",\"code\":\"E\"}],\"destination\":[{\"region\":\"Southern Africa\",\"code\":\"A\"},{\"region\":\"Africa\",\"code\":\"B\"},{\"region\":\"Australia and New Zealand\",\"code\":\"F\"},{\"region\":\"Central America\/Caribbean and Hawaii\",\"code\":\"J\"},{\"region\":\"Central Asia\",\"code\":\"H\"},{\"region\":\"Europe\",\"code\":\"C\"},{\"region\":\"Middle East\",\"code\":\"D\"},{\"region\":\"North America\",\"code\":\"I\"},{\"region\":\"North and South Asia\",\"code\":\"G\"},{\"region\":\"South America\",\"code\":\"E\"}],\"cabinClass\":[{\"cabinType\":\"Economy\",\"code\":\"X\"},{\"cabinType\":\"Business\",\"code\":\"I\"},{\"cabinType\":\"First\",\"code\":\"O\"}]}},\"nonAirRewards\":[{\"awardType\":\"Car Rental\",\"awardCode\":\"C\",\"dynamicAttributeCity\":\"CRCTY\",\"partners\":[{\"partnerName\":\"Avis Car Rental (Pty) Limited\",\"partnerCode\":\"AVIS\",\"partnerGroups\":[\"A\",\"B\",\"C\",\"D\",\"E\",\"F\",\"G\",\"H\",\"I\",\"J\",\"K\",\"L\",\"M\",\"N\",\"O\",\"P\",\"PBP\"]},{\"partnerName\":\"Avis Point 2 Point\",\"partnerCode\":\"AVP2P\",\"partnerGroups\":[\"A\",\"B\",\"C\",\"I\",\"K\"]}]},{\"awardType\":\"Lifestyle\",\"awardCode\":\"L\",\"partners\":[{\"partnerName\":\"Cruises International\",\"partnerCode\":\"ICRUS\",\"partnerGroups\":[]},{\"partnerName\":\"Health Spas Guide\",\"partnerCode\":\"HSPAS\",\"partnerGroups\":[]}]}]}";
    AirRewards airRewards = AirRewards.fromJson(jsonDecode(jsonData));
    airRewards.saaAwards.forEach((element) {
      element.awards.forEach((award) {
        saaAwardNames.add(award.awardName);
      });
    });
    airRewards.saaAwards.forEach((element) {
      element.awardTypes.forEach((awardType) {
        if (!saaAwardTypes.contains('MileageKeeper')) {
          saaAwardTypes.add(awardType.awardName);
        }
      });
    });
    airRewards.saaAwards.forEach((element) {
      element.regions.forEach((element) {
        if (!regionTravells.contains('Travel within South African cities')) {
          regionTravells.add(element.regionOfTravel);
        }
      });
    });
    airRewards.saaAwards.forEach((element) {
      element.cabinClass.forEach((element) {
        if (!saaCabinClasses.contains('Economy')) {
          saaCabinClasses.add(element.cabinType);
        }
      });
    });
    airRewards.saaAwards.forEach((element) {
      element.searchType.forEach((element) {
        if (!saaSearchTypes.contains('One Way') || element != 'One Way') {
          saaSearchTypes.add(element);
        }
      });
    });

    airRewards.starAllianceAwards.cabinClass.forEach((element) {
      if (!starCabinClasses.contains('Business') ||
          element.cabinType != 'Business') {
        starCabinClasses.add(element.cabinType);
      }
    });
    airRewards.starAllianceAwards.awards.forEach((element) {
      starAllianceAwardNames.add(element.awardName);
    });
    airRewards.starAllianceAwards.searchType.forEach((element) {
      starSearchTypes.add(element);
    });
    airRewardsNames.addAll(airPartners);
    print(airRewards.saaAwards);
    print(airRewards.starAllianceAwards);
    print(airRewards);
  }

  void checkAirRewards(String airReward) {
    if (airReward == 'StarAllianceAwards') {
      //commonAwardNames.clear();
      awardName = starAllianceAwardNames.elementAt(0);
      commonAwardNames = starAllianceAwardNames;
      cabinClass = starCabinClasses.elementAt(0);
      commonCabinClasses = starCabinClasses;
      searchType = starSearchTypes.elementAt(0);
      commonSearchType = starSearchTypes;
    } else {
      awardName = saaAwardNames.elementAt(0);
      commonAwardNames = saaAwardNames;
      cabinClass = saaCabinClasses.elementAt(0);
      commonCabinClasses = saaCabinClasses;
      searchType = saaSearchTypes.elementAt(0);
      saaSearchTypes.removeLast();
      commonSearchType = saaSearchTypes;
    }
  }
}
