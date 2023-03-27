// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:chatapp/services/reviewservice.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key, required this.doctor_id}) : super(key: key);
  final String doctor_id;

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  Map<String, dynamic> _data = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Dio dio = new Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';
    final res = await dio
        .get('https://medapp-jts3.onrender.com/doctors/${widget.doctor_id}');

    setState(() {
      _data = res.data;
    });
  }

  void _addForm() async {
    Map<String, dynamic>? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddReview();
      },
    );
    if (result != null) {
      double rating = result['rating'] as double;
      String review = result['review'] as String;
      ReviewService().addreview(widget.doctor_id, rating, review);
      setState(() {
        fetchData();
      });
    }
  }

  // void _editForm() async {
  //   Map<String, dynamic>? result = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return EditReview();
  //     },
  //   );
  //   if (result != null) {
  //     double rating = result['rating'] as double;
  //     String review = result['review'] as String;
  //     // ReviewService().updatereview(rating, review);
  //   }
  // }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedTime = DateFormat.Hm().format(dateTime);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return '$formattedTime, $formattedDate';
  }

  @override
  Widget build(BuildContext context) {
    if (_data.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    final doctor = _data['doctor'];
    final reviews = _data['reviews'];
    double sum = 0;
    for (int i = 0; i < reviews.length; i++) {
      sum += reviews[i]['rate'];
    }
    double averageRating = sum / reviews.length;
    double roundedRating = double.parse(averageRating.toStringAsFixed(1));

    double doctorReview = roundedRating <= 5 ? roundedRating : 5;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          child: SvgPicture.asset("images/user.svg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctor['name'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              doctor['speciality'],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 40),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Container(
                            //       padding: EdgeInsets.all(8),
                            //       decoration: BoxDecoration(
                            //           color: Colors.amber.shade400,
                            //           shape: BoxShape.circle),
                            //       child: Icon(
                            //         Icons.email,
                            //         color: Colors.white,
                            //         size: 15,
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 15,
                            //     ),
                            //     Text(
                            //       'doctor@gmail.com',
                            //       style: TextStyle(
                            //           fontSize: 12,
                            //           letterSpacing: 2,
                            //           color: Colors.white),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 5,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Container(
                            //       padding: EdgeInsets.all(8),
                            //       decoration: BoxDecoration(
                            //           color: Colors.amber.shade400,
                            //           shape: BoxShape.circle),
                            //       child: Icon(
                            //         Icons.call,
                            //         color: Colors.white,
                            //         size: 15,
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 15,
                            //     ),
                            //     Text(
                            //       '+216 xx xxx xxx',
                            //       style: TextStyle(
                            //           fontSize: 12,
                            //           letterSpacing: 2,
                            //           color: Colors.white),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              width: double.infinity,
              padding: EdgeInsets.only(top: 40, left: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "About Doctor",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    doctor['name'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Text(
                        "Reviews",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.star,
                        color: Colors.amber.shade400,
                      ),
                      Text(
                        "${doctorReview}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "(${reviews.length})",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: primaryColor),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: _addForm,
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                    child: SvgPicture.asset("images/user.svg"),
                                  ),
                                  title: Text(
                                    reviews[index]["author"]["username"],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      formatDate(reviews[index]["created_at"])),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber.shade400,
                                      ),
                                      Text(
                                        "${reviews[index]["rate"]}",
                                        style: TextStyle(color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        reviews[index]["review"],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // Icon(
                                          //   Icons.edit,
                                          //   color: Colors.black,
                                          //   size: 15,
                                          // ),
                                          // SizedBox(
                                          //   width: 10,
                                          // ),
                                          TextButton(
                                            onPressed: () {
                                              ReviewService().deletereview(
                                                  reviews[index]['_id']);
                                              setState(() {
                                                fetchData();
                                              });
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration:
                          BoxDecoration(color: bgColor, shape: BoxShape.circle),
                      child: Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 30,
                      ),
                    ),
                    title: Text(
                      doctor['city'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      doctor['location'],
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          "Consultation Price",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          "60 TND",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.amber.shade400,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Book appointment",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class AddReview extends StatefulWidget {
  const AddReview({super.key});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  TextEditingController _textController = TextEditingController();
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: _rating >= 1 ? Icon(Icons.star) : Icon(Icons.star_border),
                color: Colors.amber,
                onPressed: () {
                  setState(() {
                    _rating = 1;
                  });
                },
              ),
              IconButton(
                icon: _rating >= 2 ? Icon(Icons.star) : Icon(Icons.star_border),
                color: Colors.amber,
                onPressed: () {
                  setState(() {
                    _rating = 2;
                  });
                },
              ),
              IconButton(
                icon: _rating >= 3 ? Icon(Icons.star) : Icon(Icons.star_border),
                color: Colors.amber,
                onPressed: () {
                  setState(() {
                    _rating = 3;
                  });
                },
              ),
              IconButton(
                icon: _rating >= 4 ? Icon(Icons.star) : Icon(Icons.star_border),
                color: Colors.amber,
                onPressed: () {
                  setState(() {
                    _rating = 4;
                  });
                },
              ),
              IconButton(
                icon: _rating >= 5 ? Icon(Icons.star) : Icon(Icons.star_border),
                color: Colors.amber,
                onPressed: () {
                  setState(() {
                    _rating = 5;
                  });
                },
              ),
            ],
          ),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Enter your review',
              border: OutlineInputBorder(),
            ),
            minLines: 1,
            maxLines: 5,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop({
              'rating': _rating,
              'review': _textController.text,
            });
          },
        ),
      ],
    );
  }
}

// class EditReview extends StatefulWidget {
//   const EditReview({super.key});

//   @override
//   State<EditReview> createState() => _EditReviewState();
// }

// class _EditReviewState extends State<EditReview> {
//   TextEditingController _textController = TextEditingController();
//   double _rating = 0;
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Edit Review'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               IconButton(
//                 icon: _rating >= 1 ? Icon(Icons.star) : Icon(Icons.star_border),
//                 color: Colors.amber,
//                 onPressed: () {
//                   setState(() {
//                     _rating = 1;
//                   });
//                 },
//               ),
//               IconButton(
//                 icon: _rating >= 2 ? Icon(Icons.star) : Icon(Icons.star_border),
//                 color: Colors.amber,
//                 onPressed: () {
//                   setState(() {
//                     _rating = 2;
//                   });
//                 },
//               ),
//               IconButton(
//                 icon: _rating >= 3 ? Icon(Icons.star) : Icon(Icons.star_border),
//                 color: Colors.amber,
//                 onPressed: () {
//                   setState(() {
//                     _rating = 3;
//                   });
//                 },
//               ),
//               IconButton(
//                 icon: _rating >= 4 ? Icon(Icons.star) : Icon(Icons.star_border),
//                 color: Colors.amber,
//                 onPressed: () {
//                   setState(() {
//                     _rating = 4;
//                   });
//                 },
//               ),
//               IconButton(
//                 icon: _rating >= 5 ? Icon(Icons.star) : Icon(Icons.star_border),
//                 color: Colors.amber,
//                 onPressed: () {
//                   setState(() {
//                     _rating = 5;
//                   });
//                 },
//               ),
//             ],
//           ),
//           TextField(
//             controller: _textController,
//             decoration: InputDecoration(
//               hintText: 'Enter your review',
//               border: OutlineInputBorder(),
//             ),
//             minLines: 1,
//             maxLines: 5,
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: Text('CANCEL'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: Text('OK'),
//           onPressed: () {
//             Navigator.of(context).pop({
//               'rating': _rating,
//               'review': _textController.text,
//             });
//           },
//         ),
//       ],
//     );
//   }
// }
