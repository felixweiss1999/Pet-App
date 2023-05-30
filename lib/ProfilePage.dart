import 'package:flutter/material.dart';
import 'package:pet_app/AddPetProfile.dart';
import 'package:pet_app/StoryPage.dart';
import 'CustomWidget.dart';
import 'CustomButton.dart';
import 'PetApp.dart';
import 'package:album_image/album_image.dart';
import 'AddPetProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.person});
  final UserData person;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  CustomWidget cw = new CustomWidget();
  String gender = "";
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Color.fromRGBO(96, 175, 245, 1), size: 30),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.person.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            // Added height to the container
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                profile_info(widget.person.photo, widget.person.posts_count,
                    widget.person.follower, true),
                Text_info(widget.person.intro, true),
                Text_title("寵物資料"),
                Pets_photo(widget.person.petdatas, true),
                Text_title("寵物相簿"),
                Album(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profile_info(
      String file_name, int posts_count, int followers, bool is_user) {
    if (is_user) {
      return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: cw.Profile_photo(35, file_name: file_name),
                flex: 1,
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: cw.Text_count("追蹤者", followers),
                      flex: 1,
                    ),
                    Spacer(),
                    Flexible(
                      child: cw.Text_count("追蹤中", 50),
                      flex: 1,
                    ),
                    Spacer(),
                    Flexible(
                      child: cw.Text_count("貼文數", posts_count),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ],
          ));
    }

    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: cw.Profile_photo(35, file_name: file_name),
              flex: 1,
            ),
            Expanded(
                flex: 2,
                child: Column(children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: cw.Text_count("追蹤者", followers),
                        flex: 1,
                      ),
                      Spacer(),
                      Flexible(
                        child: cw.Text_count("追蹤中", 50),
                        flex: 1,
                      ),
                      Spacer(),
                      Flexible(
                        child: cw.Text_count("貼文數", posts_count),
                        flex: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () {
                            // 按钮点击事件
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                Color.fromRGBO(170, 227, 254, 1), // 设置背景颜色为蓝色
                          ),
                          child: Text(
                            '追蹤',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold, // 设置字体颜色为黑色
                            ),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () {
                            // 按钮点击事件
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                Color.fromRGBO(170, 227, 254, 1), // 设置背景颜色为蓝色
                          ),
                          child: Text(
                            '聊天',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold, // 设置字体颜色为黑色
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ])),
          ],
        ));
  }

  Widget Text_title(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Text_info(String info, bool is_user) {
    return Column(
      children: [
        Row(
          children: [
            Text_title("飼主簡介"),
            if (is_user)
              IconButton(
                onPressed: () {
                  // 按钮点击事件
                },
                icon: Icon(Icons.mode_edit),
              ),
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(96, 175, 245, 1),
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              )),
          child: Text(
            info,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget Pets_photo(List<PetDetail> petsList, bool isUser) {
    return Container(
      padding: EdgeInsets.all(25.0),
      child: Row(
        children: [
          ...petsList.map((pet) {
            String fileName =
                pet.photo.isEmpty ? "assets/image/empty.jpg" : pet.photo;
            return GestureDetector(
              onTap: () {
                showPetProfile(pet);
              },
              child: Padding(
                padding:
                    EdgeInsets.only(right: 20.0), // Add spacing between items
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(fileName),
                ),
              ),
            );
          }).toList(),
          if (isUser)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPetProfilePage(),
                    maintainState: false,
                  ),
                );
              },
              child: Padding(
                padding:
                    EdgeInsets.only(right: 10.0), // Add spacing between items
                child: CircleAvatar(
                  radius: 35,
                  foregroundImage: AssetImage('assets/image/AddPetProfile.png'),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<dynamic> showPetProfile(PetDetail pet) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
        var dialogWidth = screenSize.width * 1 / 2;
        var dialogHeight = screenSize.height * 1 / 2;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
                color: Color.fromRGBO(96, 175, 245, 1),
                width: 3.0), // Add the desired blue color
          ),
          child: Container(
            width: dialogWidth,
            height: dialogHeight,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 30.0),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(pet.photo),
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            pet.name,
                            style: TextStyle(
                                fontSize: 32.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child:
                              Text(pet.breed, style: TextStyle(fontSize: 16.0)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('${pet.age.toString()} / ${pet.gender}',
                              style: TextStyle(fontSize: 16.0)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft, // Align left
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.0), // Add left padding
                    child: Text(
                      '個性標籤',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.0), // Add left padding
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align left
                      children: List.generate(
                        pet.personality_lable.length,
                        (index) => Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(170, 227, 254,
                                1), // Add the desired background color
                            border: Border.all(
                              color: Colors.white,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(pet.personality_lable[index]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget Album(BuildContext context) {
    return Column(
      children: [
        for (int index = 0; index < _images.length; index += 3)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = index; i < index + 3 && i < _images.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 0,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StoryPage(Post_list: [], Post_Index: 0)),
                            ).then((value) {
                              // Do something with returned data
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              _images[i].imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

// from: https://github.com/kaycobad/gallery_app/tree/master/lib
class ImageDetails {
  final String imagePath;
  final String price;
  final String photographer;
  final String title;
  final String details;
  ImageDetails({
    required this.imagePath,
    required this.price,
    required this.photographer,
    required this.title,
    required this.details,
  });
}

List<ImageDetails> _images = [
  ImageDetails(
    imagePath: 'assets/image/dog4.jpg',
    price: '\$20.00',
    photographer: 'Martin Andres',
    title: 'New Year',
    details:
        'This image was taken during a party in New York on new years eve. Quite a colorful shot.',
  ),
  ImageDetails(
    imagePath: 'assets/image/dog5.jpg',
    price: '\$10.00',
    photographer: 'Abraham Costa',
    title: 'Spring',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'assets/image/dog6.jpg',
    price: '\$30.00',
    photographer: 'Jamie Bryan',
    title: 'Casual Look',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'assets/image/dog7.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'assets/image/dog8.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'assets/image/dog9.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
];
