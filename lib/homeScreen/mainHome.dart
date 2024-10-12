import 'package:flutter/material.dart';
import 'package:happy_plum/homeScreen/animals.dart';
import 'package:happy_plum/homeScreen/details.dart';
import 'package:happy_plum/homeScreen/lessons.dart';
import 'package:happy_plum/homeScreen/quiz.dart';

import 'package:flutter/animation.dart';
import 'dart:math';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Define the shaking animation from -30 to 30 degrees (left to right)
    _animation = Tween<double>(begin: -7.0, end: 7.0)
        .chain(CurveTween(curve: Curves.elasticInOut))
        .animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse(); // Reverse when animation completes
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward(); // Repeat the animation
        }
      });

    // Start the shaking animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.purple[400],
        title: Row(
          children: [
            Image.asset(
              'assets/happy.jpg', // Replace with your image URL
              height: 45, // Adjust size as needed
            ),
            const SizedBox(width: 10),
            const Text(
              'Happy Plum',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple[400],
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/happy.jpg', // Replace with your image URL
                    height: 65, // Adjust size as needed
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Happy Plum',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.white),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Student Dashboard',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.home_work,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Homework'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.book,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Rubric'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.real_estate_agent,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Real Life Scenario'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.book,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Lessons'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Lessons()));
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.rocket,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Goals'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.file_copy,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Curriculum'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.message,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Message'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.rocket_launch,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Performance'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.star_border_outlined,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Review Sheet'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_emotions_outlined,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Cultural Highlight'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Flash cards'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.assessment,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Test/Assesment'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
            ListTile(
              leading: Icon(Icons.build,
                  color: Colors.purple[400]), // Set the icon color to white
              title: const Text('Project'),
              onTap: () {
                Navigator.pop(context);
                // Add navigation functionality if required
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              '  Choose a category',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Details()));
                  },
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animation.value * pi / 360,
                          child: Container(
                            height: 229,
                            width: (screenWidth / 2) - 20,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 111, 190, 114),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      'https://images.pexels.com/photos/68525/soap-colorful-color-fruit-68525.jpeg?auto=compress&cs=tinysrgb&w=400',
                                      height: 170,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Center(
                                    child: Text(
                                      'Fruits',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                GestureDetector(
                  // onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => ShakingContainer()));
                  // },
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animation.value * pi / 360,
                          child: Container(
                            height: 229,
                            width: (screenWidth / 2) - 20,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 66, 142, 204),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      'https://images.pexels.com/photos/142520/pexels-photo-142520.jpeg?auto=compress&cs=tinysrgb&w=400',
                                      height: 170,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Center(
                                    child: Text(
                                      'Vegetables',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Animals()));
                  },
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animation.value * pi / 360,
                          child: Container(
                            height: 229,
                            width: (screenWidth / 2) - 20,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red[500],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      'https://images.pexels.com/photos/39857/leopard-leopard-spots-animal-wild-39857.jpeg?auto=compress&cs=tinysrgb&w=400',
                                      height: 170,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Center(
                                    child: Text(
                                      'Animals',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animation.value * pi / 360,
                        child: Container(
                          height: 229,
                          width: (screenWidth / 2) - 20,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.yellow[600],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    'https://images.pexels.com/photos/909907/pexels-photo-909907.jpeg?auto=compress&cs=tinysrgb&w=400',
                                    height: 170,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Center(
                                  child: Text(
                                    'Transportation',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animation.value * pi / 360,
                        child: Container(
                          height: 229,
                          width: (screenWidth / 2) - 20,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.yellow[800],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    'https://images.pexels.com/photos/1148496/pexels-photo-1148496.jpeg?auto=compress&cs=tinysrgb&w=400',
                                    height: 170,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Center(
                                  child: Text(
                                    'Shapes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animation.value * pi / 360,
                        child: Container(
                          height: 229,
                          width: (screenWidth / 2) - 20,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 80, 170, 215),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    'https://images.pexels.com/photos/209831/pexels-photo-209831.jpeg?auto=compress&cs=tinysrgb&w=400',
                                    height: 170,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Center(
                                  child: Text(
                                    'Weather',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Quiz()));
                },
                child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animation.value * pi / 360,
                        child: Container(
                          height: 249,
                          width: (screenWidth / 2) - 10,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red[400],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&w=400',
                                    height: 190,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Center(
                                  child: Text(
                                    'Animal Quiz',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
