import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app_i2it/provider/current_user_provider.dart';
import 'package:hostel_app_i2it/services/auth_services.dart';
import 'package:hostel_app_i2it/size_config.dart';
import 'package:provider/provider.dart';

class SmartRoom extends StatelessWidget {
  const SmartRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Smart Room',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(getProportionateScreenWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getProportionateScreenWidth(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(10),
                ),
                child: SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15)),
                        child: Row(
                          children: [
                            Text(
                              'In your room',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(20),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 2,
                        indent: getProportionateScreenWidth(8),
                        endIndent: getProportionateScreenWidth(8),
                        height: getProportionateScreenHeight(5),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(15)),
                        child: Row(
                          children: [
                            Text(
                              'Devices Connect\n2 online',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(10),
                                    ),
                                  ),
                                  primary: const Color(0xFF70B6B0)),
                              onPressed: () {},
                              child: Center(
                                child: Text(
                                  'Check',
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Text(
              'Connected Devices',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: getProportionateScreenWidth(10),
                children: const [
                  LedSwitch(),
                  FanSwitch(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LedSwitch extends StatefulWidget {
  const LedSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<LedSwitch> createState() => _LedSwitchState();
}

class _LedSwitchState extends State<LedSwitch> {
  @override
  Widget build(BuildContext context) {
    final userData =
        Provider.of<CurrentUserProvider>(context, listen: false).getUserData;
    return StreamBuilder<DatabaseEvent>(
      stream: FirebaseDatabase.instance
          .ref('${userData['bookedRoomNo']}/LED')
          .onValue,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        bool ledValue = snapshot.data!.snapshot.value as bool;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            border: Border.all(
              color: ledValue ? const Color(0xFF70B6B0) : Colors.black,
              width: 2,
            ),
            color: ledValue ? const Color(0xFF70B6B0) : Colors.white,
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  AnimatedContainer(
                    margin: EdgeInsets.all(getProportionateScreenWidth(20)),
                    duration: const Duration(milliseconds: 500),
                    padding: EdgeInsets.all(getProportionateScreenWidth(2)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(5),
                      ),
                      color: ledValue ? Colors.white : const Color(0xFF70B6B0),
                    ),
                    child: Icon(
                      Icons.lightbulb_outline_rounded,
                      size: getProportionateScreenWidth(30),
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    activeTrackColor: Colors.white,
                    thumbColor: MaterialStateProperty.all(
                      const Color(0xFF70B6B0),
                    ),
                    value: ledValue,
                    onChanged: (value) {
                      AuthServices().toggleLed(
                          'LED', !ledValue, userData['bookedRoomNo']);
                    },
                  ),
                ],
              ),
              Text(
                'LED',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                  color: ledValue ? Colors.white : Colors.black,
                ),
              ),
              Text(
                'Status: ${ledValue ? 'ON' : 'OFF'}',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  color: ledValue ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FanSwitch extends StatefulWidget {
  const FanSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<FanSwitch> createState() => _FanSwitchState();
}

class _FanSwitchState extends State<FanSwitch> {
  @override
  Widget build(BuildContext context) {
    final userData =
        Provider.of<CurrentUserProvider>(context, listen: false).getUserData;

    return StreamBuilder<DatabaseEvent>(
      stream: FirebaseDatabase.instance
          .ref('${userData['bookedRoomNo']}/FAN')
          .onValue,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        bool ledValue = snapshot.data!.snapshot.value as bool;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            border: Border.all(
              color: ledValue ? const Color(0xFF70B6B0) : Colors.black,
              width: 2,
            ),
            color: ledValue ? const Color(0xFF70B6B0) : Colors.white,
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  AnimatedContainer(
                    margin: EdgeInsets.all(getProportionateScreenWidth(20)),
                    duration: const Duration(milliseconds: 500),
                    padding: EdgeInsets.all(getProportionateScreenWidth(2)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(5),
                      ),
                      color: ledValue ? Colors.white : const Color(0xFF70B6B0),
                    ),
                    child: Icon(
                      Icons.lightbulb_outline_rounded,
                      size: getProportionateScreenWidth(30),
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    activeTrackColor: Colors.white,
                    thumbColor: MaterialStateProperty.all(
                      const Color(0xFF70B6B0),
                    ),
                    value: ledValue,
                    onChanged: (value) {
                      AuthServices().toggleLed(
                          'FAN', !ledValue, userData['bookedRoomNo']);
                      setState(() {
                        ledValue = !ledValue;
                      });
                    },
                  ),
                ],
              ),
              Text(
                'FAN',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                  color: ledValue ? Colors.white : Colors.black,
                ),
              ),
              Text(
                'Status: ${ledValue ? 'ON' : 'OFF'}',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  color: ledValue ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
