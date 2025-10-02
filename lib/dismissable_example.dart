import 'package:flutter/material.dart';

class DismissibleExample extends StatefulWidget {
  const DismissibleExample({super.key});

  @override
  State<DismissibleExample> createState() => _DismissibleExampleState();
}

class _DismissibleExampleState extends State<DismissibleExample> {
  List<String> items = List<String>.generate(
    20,
    (index) => 'Item ${index + 1}',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dismissible Example')),

      body: ListView.separated(
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            crossAxisEndOffset: 0.5,
            key: Key(items[index]),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              final deletedItem = items[index];
              setState(() {
                items.removeAt(index);
              });
              _showSnack(context, index, deletedItem);
            },
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(items[index]),
              onTap: () {},
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 20),
        itemCount: items.length,
      ),
    );
  }

  void _showSnack(BuildContext context, int index, String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item $value was deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              items.insert(index, value);
            });
          },
        ),
      ),
    );
  }
}



// class LoadingDots extends StatefulWidget {
//   const LoadingDots({super.key});

//   @override
//   State<LoadingDots> createState() => _LoadingDotsState();
// }

// class _LoadingDotsState extends State<LoadingDots>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   late List<Animation<double>> _scales;
//   late List<Animation<double>> _opacities;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat();

//     _scales = List.generate(3, (i) {
//       return Tween<double>(begin: 0.7, end: 2).animate(
//         CurvedAnimation(
//           parent: _controller,
//           curve: Interval(
//             i * (1 / 3), // start
//             (i + 1) * (1 / 3),
//             curve: Curves.easeInOut,
//           ),
//         ),
//       );
//     });

//     _opacities = List.generate(3, (i) {
//       return Tween<double>(begin: 0.3, end: 1.0).animate(
//         CurvedAnimation(
//           parent: _controller,
//           curve: Interval(
//             i * (1 / 3), // start
//             (i + 1) * (1 / 3),
//             curve: Curves.easeInOut,
//           ),
//         ),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose(); // مهم جداً عشان نتجنب memory leaks
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           width: 80,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: List.generate(3, (i) {
//               return AnimatedBuilder(
//                 animation: _controller,
//                 builder: (context, child) {
//                   return Opacity(
//                     opacity: _opacities[i].value,
//                     child: Transform.scale(
//                       scale: _scales[i].value,
//                       child: Container(
//                         width: 12,
//                         height: 12,
//                         decoration: const BoxDecoration(
//                           color: Colors.blue,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }