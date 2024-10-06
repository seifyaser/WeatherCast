import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchFloatingActionButton extends StatelessWidget {
  final bool isLoading;
  final Function(String) onSearch;

  const SearchFloatingActionButton({
    Key? key,
    required this.isLoading,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Container(
          width: 70,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5, 
              )),
          child: FloatingActionButton(
              onPressed: () {
                // عند الضغط على الزر، افتح مربع الحوار لإدخال اسم المدينة
                showDialog(
                  context: context,
                  builder: (context) {
                    String cityName = '';
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(35), 
                      // ),
                      child: Container(
                         decoration: BoxDecoration(
                       color: Colors.white.withOpacity(0.8), // ضبط اللون مع مستوى الشفافية
                        borderRadius: BorderRadius.circular(30),
                         ), 
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Enter City Name',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              onChanged: (value) {
                                cityName = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'City Name',
                                border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.blue, width: 2), 
                                  ),
                                 focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30), 
                                borderSide: BorderSide(color: Colors.blueAccent, width: 2), 
                                ),
                               enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30), // زوايا مستديرة
                                borderSide: BorderSide(color: Colors.grey, width: 2), 
                                ),
                                ),
                              ),
                            
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (cityName.isNotEmpty) {
                                  onSearch(cityName);
                                }
                                Navigator.of(context).pop();
                              },
                              child: Text('Search',style: TextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff7d49ca).withOpacity(0.9), // لون الزر
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              backgroundColor: Color(0xff7d49ca).withOpacity(0.4),
              child: Icon(MdiIcons.mapSearch, size: 30, color: Colors.white),
            ),
        )
        : SizedBox(); // إذا كان في حالة تحميل، لا يظهر أي شيء
  }
}
