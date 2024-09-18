import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:users_app/src/presentation/features/auth/pages/login_page.dart';
import 'package:users_app/src/presentation/misc/constant.dart';
import 'package:users_app/src/presentation/misc/methods.dart';
import 'package:users_app/src/presentation/misc/style.dart';
import 'package:users_app/src/presentation/widgets/fab.dart';
import 'package:users_app/src/presentation/widgets/textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController titleController = TextEditingController();
TextEditingController descController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController searchController = TextEditingController();

GlobalKey<FormState> formKey = GlobalKey<FormState>();

String? uid;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // getUid();

    super.initState();
  }

  /* getUid() async {
    uid = _authDataSource.getInLoggedUser();
    await _taskDatasource.searchTasks(
      uid: uid ?? '',
      query: searchController.text,
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: FAB(
        onTap: () {},
      ),
      body: ListView(
        children: [
          verticalSpace(20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: primaryDarkColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.8),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'User List',
                  style: whiteSemiBoldTextStyle.copyWith(fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getGreeting(),
                      style: whiteMediumTextStyle.copyWith(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (FirebaseAuth.instance.currentUser == null) {
                          setState(() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: whiteColor,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 2,
                  color: ghostWhite,
                ),
                verticalSpace(10),
                KTextField(
                  isDense: true,
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.search,
                  controller: searchController,
                  borderColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  placeholder: 'Search your task',
                  placeholderStyle:
                      whiteRegularTextStyle.copyWith(fontSize: 14),
                  onChanged: (value) {
                    /* _taskDatasource.searchTasks(
                        uid: uid ?? '',
                        query: value == '' ? value : capitalizeEachWord(value));
                    setState(() {}); */
                  },
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 30,
                    color: ghostWhite,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [],
            ),
          )
        ],
      ),
    );
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 11) {
      return "Good Morning";
    } else if (hour >= 11 && hour < 15) {
      return "Good Afternoon";
    } else if (hour >= 15 && hour < 18) {
      return "Good Afternoon";
    } else if (hour >= 18 && hour < 24) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }
/* 
  showDatePicker(BuildContext context) {
    AlertDialog alert = AlertDialog(
      surfaceTintColor: whiteColor,
      backgroundColor: whiteColor,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SfDateRangePicker(
              backgroundColor: whiteColor,
              onSelectionChanged:
                  (DateRangePickerSelectionChangedArgs value) {},
              showActionButtons: true,
              confirmText: 'Confirm',
              cancelText: 'Cancel',
              onCancel: () {
                Navigator.pop(context);
              },
              onSubmit: (val) {
                setState(() {
                  dateController.text = FormatDate().formatDate(val.toString(),
                      context: context, format: 'dd MMMM yyyy');
                });
                Navigator.pop(context);
              },
              selectionColor: primaryColor,
              todayHighlightColor: primaryColor,
              rangeSelectionColor: primaryColor.withOpacity(0.75),
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedDate: DateTime.now(),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  } */
}
