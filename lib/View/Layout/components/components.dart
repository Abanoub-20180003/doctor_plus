// ignore_for_file: non_constant_identifier_names

import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:flutter/material.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:toast/toast.dart';
import 'constants.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

Widget MainButton({
  double width = double.infinity,
  required String text,
  required function,
  double radius = 5,
  Color color = Colors.blue,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          "${text}",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget DeleteButton({
  double width = double.infinity,
  required String text,
  required function,
  Color color = Colors.blue,
}) =>
    Container(
      width: width,
      color: color,
      child: MaterialButton(
        onPressed: function,
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: Colors.white70,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "${text}",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );

// Widget defaultTextButton({
//
//   required String text,
//   required function,
// }) =>  TextButton(
//     onPressed: function ,
//     child: Text("${text.toUpperCase()}" , style: TextStyle(color: secondColor),),
// );

Widget InputField({
  required Controller,
  required type,
  required text,
  required Icon,
  required validate,
  readonly = false,
  obscureText = false,
  onchange,
  onTap,
  onsumbit,
  Suffixicon = null,
  functionSuffix = null,
}) =>
    TextFormField(
      enableInteractiveSelection: false, // will disable paste operation
      readOnly: readonly,
      controller: Controller,
      keyboardType: type,
      onChanged: onchange,
      onTap: onTap,
      obscureText: obscureText,
      validator: validate,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        labelText: "${text}",
        border: OutlineInputBorder(),
        prefixIcon: Icon,
        suffixIcon: Suffixicon != null && functionSuffix != null
            ? IconButton(onPressed: functionSuffix, icon: Suffixicon)
            : null,
      ),
    );

// void showToast({required String msg,required ToastStatus })=>Toast.show(msg, duration: 3, gravity: Toast.bottom ,backgroundColor: chooseToastColor(ToastStatus));
//
//
// void showToast2({required String msg,required ToastStatus })=>Toast.show(msg, duration: 3, gravity: Toast.bottom ,backgroundColor: chooseToastColor(ToastStatus));

enum ToastColor { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastColor state) {
  Color color;
  switch (state) {
    case ToastColor.SUCCESS:
      color = Colors.green;
      break;
    case ToastColor.ERROR:
      color = Colors.red;
      break;
    case ToastColor.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget NewsItem(article, context) => Padding(
      padding: const EdgeInsets.all(1.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(article['urlToImage'] != null
                        ? article['urlToImage']
                        : 'https://th.bing.com/th/id/R.aae3bebceec28de9e936b57360d5d7dd?rik=4GCmQ4oAD4oDBw&pid=ImgRaw&r=0'),
                  )),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.headline5,
                    maxLines: 2,
                  ),
                  Text(
                      article['description'] != null
                          ? article['description']
                          : article['publishedAt'],
                      style: Theme.of(context).textTheme.headline6),
                  MaterialButton(
                    color: Colors.redAccent,
                    child: Text(
                      "Read More",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

Widget divider() => Padding(
    padding: const EdgeInsets.all(1.0),
    child: SizedBox(
      height: 10,
    ));

Widget articleList(list, context) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => NewsItem(list[index], context),
        itemCount: 10,
        separatorBuilder: (context, index) => divider(),
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void navigateAndFinsih(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) {
        return false;
      },
    );

Widget box_main_market_brands(text, image, fun, context) => Container(
      decoration: BoxDecoration(
        // color: thirdColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Row(
          children: [
            TextButton(
              onPressed: fun,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10),
                      child: Image(
                        image: NetworkImage(
                            'https://carcommintyu.s3.us-east-2.amazonaws.com/' +
                                'brands/cars/' +
                                image),
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      text,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget box(text, image, fun, context) => Container(
      decoration: BoxDecoration(
        color: thirdColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Row(
          children: [
            TextButton(
              onPressed: fun,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10),
                      child: Image(
                        image: AssetImage('Assets/images/' + image),
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      text,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget box_with_border(text, image, fun, context) => Container(
      decoration: BoxDecoration(
        // border: Border(
        //   left: BorderSide(width: 2.0, color: defaultColor ),
        //   top: BorderSide(width: 2.0, color: defaultColor ),
        //   bottom: BorderSide(width: 2.0, color: defaultColor ),
        //   right: BorderSide(width: 2.0, color: defaultColor ),
        // ),
        // color: thirdColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Container(
          decoration: BoxDecoration(),
          child: Row(
            children: [
              TextButton(
                onPressed: fun,
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10),
                        child: Image(
                          image: AssetImage('Assets/images/' + image),
                          width: 60,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        text,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget loading(context) => Center(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
// color: thirdColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                CircularProgressIndicator(),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Loading ...",
                )
              ],
            ),
          )),
    ));

//
//
//
//
// Widget DropDownList () {
//
//    List<SelectedListItem> _listOfCities = [
//     SelectedListItem(
//       name: "kTokyo",
//       value: "TYO",
//       isSelected: false,
//     ),
//     SelectedListItem(
//       name: "kNewYork",
//       value: "NY",
//       isSelected: false,
//     ),
//     SelectedListItem(
//       name: "kLondon",
//       value: "LDN",
//       isSelected: false,
//     ),
//     SelectedListItem(name: "kParis"),
//     SelectedListItem(name: "kMadrid"),
//     SelectedListItem(name: "kDubai"),
//     SelectedListItem(name: "kRome"),
//     SelectedListItem(name: "kBarcelona"),
//     SelectedListItem(name: "kCologne"),
//     SelectedListItem(name: "kMonteCarlo"),
//     SelectedListItem(name: "kPuebla"),
//     SelectedListItem(name: "kFlorence"),
//   ];
//
//   /// This is register text field controllers.
//   final TextEditingController _fullNameTextEditingController = TextEditingController();
//   final TextEditingController _emailTextEditingController = TextEditingController();
//   final TextEditingController _phoneNumberTextEditingController = TextEditingController();
//   final TextEditingController _cityTextEditingController = TextEditingController();
//   final TextEditingController _passwordTextEditingController = TextEditingController();
//

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final bool isCitySelected;
  final List<SelectedListItem>? cities;

  const AppTextField({
    required this.textEditingController,
    required this.title,
    required this.hint,
    required this.isCitySelected,
    this.cities,
    Key? key,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  /// This is on text changed method which will display on city text field on changed.
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        bottomSheetTitle: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.cities ?? [],
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              //list.add(item.id.toString());
              //brand_id_get_model= item.id;
              widget.textEditingController.text = item.name;
            }
          }
          // showSnackBar(list.toString());
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(
          height: 5.0,
        ),
        // Image(image: AssetImage('assets/images/info1.png')),

        Row(
          children: [
            // Expanded(child: Image(image: AssetImage('assets/images/info1.png'))),
            Expanded(
              child: TextFormField(
                controller: widget.textEditingController,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Car Brand is required";
                  }
                  return null;
                },
                cursorColor: Colors.black,
                onTap: widget.isCitySelected
                    ? () {
                        FocusScope.of(context).unfocus();
                        onTextFieldTap();
                      }
                    : null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  contentPadding: const EdgeInsets.only(
                      left: 8, bottom: 0, top: 0, right: 15),
                  hintText: widget.hint,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}

/// This is common class for 'REGISTER' elevated button.
class _AppElevatedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          "kREGISTER",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
        style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(70, 76, 222, 1),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
//
//
// class AppTextField extends StatefulWidget {
//   final TextEditingController textEditingController;
//   final String title;
//   final String hint;
//   final bool isCitySelected;
//   final List<SelectedListItem>? cities;
//
//
//   const AppTextField({
//     required this.textEditingController,
//     required this.title,
//     required this.hint,
//     required this.isCitySelected,
//
//     this.cities,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _AppTextFieldState createState() => _AppTextFieldState();
// }
//
// class _AppTextFieldState extends State<AppTextField> {
//   final TextEditingController _searchTextEditingController = TextEditingController();
//
//   /// This is on text changed method which will display on city text field on changed.
//   void onTextFieldTap() {
//     DropDownState(
//       DropDown(
//         bottomSheetTitle:  Text(
//         widget.title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//           ),
//         ),
//         submitButtonChild: const Text(
//           'Done',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         data: widget.cities ?? [],
//         selectedItems: (List<dynamic> selectedList) {
//           List<String> list = [];
//           for(var item in selectedList) {
//             if(item is SelectedListItem) {
//               list.add(item.id.toString());
//               brand_id_get_model= item.id;
//               widget.textEditingController.text = item.name;
//             }
//           }
//            // showSnackBar(list.toString());
//
//         },
//         enableMultipleSelection: false,
//       ),
//     ).showModal(context);
//   }
//    void showSnackBar(String message) {
//      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//    }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(widget.title),
//         const SizedBox(
//           height: 5.0,
//         ),
//         // Image(image: AssetImage('assets/images/info1.png')),
//
//
//
//             Row(
//               children: [
//                 // Expanded(child: Image(image: AssetImage('assets/images/info1.png'))),
//                 Expanded(
//                   child: TextFormField(
//                     controller: widget.textEditingController,
//                     validator: (value)
//                         {
//                           if(value== null || value == "")
//                         {
//                             return "Car Brand is required";
//                         }
//                         return null;
//                         },
//                     cursorColor: Colors.black,
//                     onTap: widget.isCitySelected
//                         ? () {
//                       FocusScope.of(context).unfocus();
//                       onTextFieldTap();
//                     }
//                         : null,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.black12,
//                       contentPadding: const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
//                       hintText: widget.hint,
//                       border: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           width: 0,
//                           style: BorderStyle.none,
//                         ),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(8.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//         const SizedBox(
//           height: 15.0,
//         ),
//       ],
//     );
//   }
// }
//
// /// This is common class for 'REGISTER' elevated button.
// class _AppElevatedButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: 60.0,
//       child: ElevatedButton(
//         onPressed: () {},
//         child: const Text(
//           "kREGISTER",
//           style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
//         ),
//         style: ElevatedButton.styleFrom(
//           primary: const Color.fromRGBO(70, 76, 222, 1),
//           textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }

void showToast({required String msg, required ToastStatus}) => Toast.show(msg,
    duration: 3,
    gravity: Toast.bottom,
    backgroundColor: chooseToastColor(ToastStatus));

void showToast2({required String msg, required ToastStatus}) => Toast.show(msg,
    duration: 3,
    gravity: Toast.bottom,
    backgroundColor: chooseToastColor(ToastStatus));

// enum ToastColor{SUCCESS,ERROR,WARNING}
//
// Color chooseToastColor(ToastColor state)
// {
//   Color color ;
//   switch(state)
//   {
//     case ToastColor.SUCCESS:
//       color = Colors.green;
//       break;
//     case ToastColor.ERROR:
//       color= Colors.red;
//       break;
//     case ToastColor.WARNING:
//       color= Colors.amber;
//       break;
//   }
//   return color;
// }
