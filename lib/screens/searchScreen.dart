// import 'package:flutter/material.dart';
// import 'package:online_grocery_app_ui/widgets/homescreenCustomwidget2.dart';
//
// class Searchscreen extends StatelessWidget {
//   const Searchscreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             // SizedBox(height: 10,),
//
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Color(0xffF2F3F2),
//                         prefixIcon: Icon(Icons.search),
//                         hintText: 'Search Item',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(18),
//                             borderSide: BorderSide.none),
//                       ),
//                     ),
//                   ),
//
//
//                   Icon(Icons.tune)
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 30,),
//
//
//           Expanded(
//             child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 8,
//             mainAxisSpacing: 8,
//               childAspectRatio: .7,
//                 ),
//                 itemBuilder: (Buildcontext, int index) {
//               return HomeScreenCustomWidget2(
//                 val: ,
//                 ontab: (){
//
//                 },
//                   image: 'asset/images/eggChicken.png',
//                   title: 'Egg Chicken Red',
//                   subtitle: '4pcs, Price',
//                 price: 1.99,
//               );
//                 },),
//           )
//           ],
//         ),
//       ),
//     );
//   }
// }
