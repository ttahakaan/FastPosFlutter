// appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50.0),
      //   child: AppBar(
      //     backgroundColor: currentBrightness == Brightness.dark
      //         ? Colors.grey.shade900
      //         : Colors.white,
      //     title: Text(
      //       "",
      //       style: TextStyle(
      //         color: currentBrightness == Brightness.dark
      //             ? Colors.white
      //             : Colors.black,
      //       ),
      //     ),
      //     actions: [
      //       Row(
      //         children: [
      //           IconButton(
      //             icon: Icon(Icons.arrow_back_ios),
      //             onPressed: () async {
      //               final messenger = ScaffoldMessenger.of(context);
      //               if (await controller.canGoBack()) {
      //                 await controller.goBack();
      //               } else {
      //                 showDialog(
      //                   context: context,
      //                   builder: (BuildContext context) {
      //                     return AlertDialog(
      //                       title: Text("FastPos"),
      //                       content: Text(
      //                           "Are you sure you want to exit the FastPos App?"),
      //                       actions: [
      //                         TextButton(
      //                           onPressed: () => Navigator.of(context).pop(),
      //                           child: Text("No"),
      //                         ),
      //                         TextButton(
      //                           onPressed: () =>
      //                               Navigator.of(context).pop(true),
      //                           child: Text("Yes"),
      //                         ),
      //                       ],
      //                     );
      //                   },
      //                 ).then((exit) {
      //                   if (exit != null && exit) {
      //                     SystemNavigator.pop();
      //                   } else {
      //                     messenger.showSnackBar(
      //                       SnackBar(content: Text("No Back History Found")),
      //                     );
      //                   }
      //                 });
      //               }
      //             },
      //             color: currentBrightness == Brightness.dark
      //                 ? Colors.white
      //                 : Colors.black,
      //           ),
      //           IconButton(
      //             icon: Icon(Icons.arrow_forward_ios),
      //             onPressed: () async {
      //               final messenger = ScaffoldMessenger.of(context);
      //               if (await controller.canGoForward()) {
      //                 await controller.goForward();
      //               } else {
      //                 messenger.showSnackBar(
      //                   SnackBar(content: Text("No Forward History Found")),
      //                 );
      //                 return;
      //               }
      //             },
      //             color: currentBrightness == Brightness.dark
      //                 ? Colors.white
      //                 : Colors.black,
      //           ),
      //           IconButton(
      //             onPressed: () {
      //               controller.reload();
      //             },
      //             icon: Icon(Icons.replay),
      //             color: currentBrightness == Brightness.dark
      //                 ? Colors.white
      //                 : Colors.black,
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // ),