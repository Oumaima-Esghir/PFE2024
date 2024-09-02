import 'dart:convert';

import 'package:dealdiscover/model/plan.dart';
import 'package:dealdiscover/screens/menus/bottomnavbar.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dealdiscover/widgets/PlanningItem.dart' as PlanningItemWidget;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool isLoading = false;
  List<Plan> plans = []; // Liste complète des plans
  List<Plan> filteredPlans = []; // Liste des plans filtrés

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _loadPlans(); // Charger les plans au démarrage
  }

  Future<void> _loadPlans() async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedPlans = await partnerpubs();
      setState(() {
        plans = fetchedPlans;
        filteredPlans = fetchedPlans; // Initialement, afficher tous les plans
      });
    } catch (e) {
      print('An error occurred while fetching plans: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterPlans() {
    print('he');
    if (_selectedDay == null) {
      setState(() {
        filteredPlans =
            plans; // Si aucune date sélectionnée, afficher tous les plans
      });
      return;
    }

    final selectedDate = _selectedDay!;
    setState(() {
      filteredPlans = plans.where((plan) {
        final dateFrom = plan.parsedDateFrom;
        final dateTo = plan.parsedDateTo;
        return dateFrom != null &&
            dateTo != null &&
            (selectedDate.isAfter(dateFrom) ||
                selectedDate.isAtSameMomentAs(dateFrom)) &&
            (selectedDate.isBefore(dateTo) ||
                selectedDate.isAtSameMomentAs(dateTo));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              loadingHandler(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 330),
              child: Image.asset(
                'assets/images/arrowL.png',
                width: 45.0,
                height: 45.0,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Planning.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 55,
            ),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _filterPlans(); // Filtrer les plans lorsque la date est sélectionnée
              },
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: MyColors.btnColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: MyColors.btnColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Colors.white,
                    ),
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: filteredPlans.length,
                            itemBuilder: (context, index) {
                              final plan = filteredPlans[index];
                              return PlanningItemWidget.PlanningItem(
                                plan: plan,
                              );
                            },
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadingHandler(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isLoading = false;
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => const BottomNavBar(),
          ),
        );
      });
    });
  }
}

Future<String> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? "";
}

Future<Map<String, String>> getHeaders() async {
  final token = await getToken();
  return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}

Future<List<Plan>> partnerpubs() async {
  final url = Uri.parse('http://192.168.1.7:3000/plans/get');
  final headers = await getHeaders(); // Obtenir les en-têtes avec le jeton
  print(headers.toString());

  try {
    final response = await http.get(url, headers: headers);
    print("data: ${response.body}");
    if (response.statusCode == 200) {
      print("API call successful. Decoding response...");

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('data') && responseData['data'] is List) {
        final List<dynamic> pubsData = responseData['data'];
        print(
            "First pub data: ${pubsData.isNotEmpty ? pubsData[0] : 'No data'}");

        // Mapper chaque élément de la liste vers un objet Plan
        List<Plan> plans = pubsData.map((pub) {
          // Gestion de la possible absence de certains champs (null safety)
          return Plan.fromMap(pub as Map<String, dynamic>);
        }).toList();

        print("Converted plans: $plans");
        return plans;
      } else {
        print("Error: 'data' key not found or is not a list");
        return [];
      }
    } else {
      print('Failed to load plans, status code: ${response.statusCode}');
      throw Exception('Failed to load plans');
    }
  } catch (e) {
    print('An error occurred: $e');
    throw Exception('Failed to load plans due to an error');
  }
}
