import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;
  final List<Course> otherCourses; // Daftar kursus lainnya

  CourseDetailScreen({required this.course, required this.otherCourses});

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool isFavorite = false;

  // Dummy data ulasan pengguna
  List<Map<String, dynamic>> userReviews = [
    {
      'userName': 'User 1',
      'stars': 5,
      'reviewText':
          'This course is amazing! I learned a lot and enjoyed every bit of it.',
    },
    {
      'userName': 'User 2',
      'stars': 4,
      'reviewText':
          'Great course content, but some sections could be more detailed.',
    },
    {
      'userName': 'User 3',
      'stars': 3,
      'reviewText':
          'Good course overall, but the exercises were a bit too easy.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              widget.course.imageUrl,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Instruktur: ${widget.course.instructor}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.course.description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Enroll Successful'),
                          content: Text(
                            'You have successfully enrolled in the course "${widget.course.title}".',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Ok'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Enroll',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ulasan Pengguna',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Ulasan pengguna
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: userReviews.length,
                    itemBuilder: (context, index) {
                      return buildReviewCard(
                        userReviews[index]['userName'],
                        userReviews[index]['stars'],
                        userReviews[index]['reviewText'],
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Kursus Lainnya',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 18),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.otherCourses.length,
                      itemBuilder: (context, index) {
                        Course otherCourse = widget.otherCourses[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseDetailScreen(
                                  course: otherCourse,
                                  otherCourses: widget.otherCourses,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 160,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        otherCourse.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    otherCourse.title,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReviewCard(String userName, int stars, String reviewText) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: List.generate(
                    stars,
                    (index) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(reviewText),
          ],
        ),
      ),
    );
  }
}
