// import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';
// import 'dart:math';

// class ShakingContainer extends StatefulWidget {
//   const ShakingContainer({super.key});

//   @override
//   _ShakingContainerState createState() => _ShakingContainerState();
// }

// class _ShakingContainerState extends State<ShakingContainer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the AnimationController
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );

//     // Define the shaking animation from -30 to 30 degrees (left to right)
//     _animation = Tween<double>(begin: -7.0, end: 7.0)
//         .chain(CurveTween(curve: Curves.elasticInOut))
//         .animate(_controller)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _controller.reverse(); // Reverse when animation completes
//         } else if (status == AnimationStatus.dismissed) {
//           _controller.forward(); // Repeat the animation
//         }
//       });

//     // Start the shaking animation
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose(); // Dispose of the controller when done
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     return Center(
//       // Center to ensure position stays unchanged
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Transform.rotate(
//             angle: _animation.value * pi / 360, // Convert degrees to radians
//             child: Container(
//               height: 289,
//               width: (screenWidth / 2) - 20,
//               margin:
//                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//               child: Material(
//                 elevation: 5,
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.purple[200],
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         topRight: Radius.circular(10),
//                       ),
//                       child: Image.network(
//                         'https://images.pexels.com/photos/104827/cat-pet-animal-domestic-104827.jpeg?auto=compress&cs=tinysrgb&w=400',
//                         height: 170,
//                         width: double.infinity,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Center(
//                       child: Text(
//                         'Cat',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 0.4,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     const Center(
//                       child: Text(
//                         'बिल्ली',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 0.4,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     const Center(
//                       child: Text(
//                         'मांजर',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 0.4,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
