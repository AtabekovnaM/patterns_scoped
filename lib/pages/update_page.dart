import 'package:flutter/material.dart';
import 'package:patterns_scoped/scopes/update_scoped.dart';



class UpdatePage extends StatefulWidget {
  static final String id = 'update_page';

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  var titleController = TextEditingController();
  var bodyController = TextEditingController();

  UpdateScoped scoped = UpdateScoped();


  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> map = ModalRoute.of(context).settings.arguments as Map;

    scoped.post.id = map["id"];
    scoped.post.title = map["title"];
    scoped.post.body = map["body"];
    scoped.post.userId = map["userId"];

    titleController.text = scoped.post.title;
    bodyController.text = scoped.post.body;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(left: 90),
          child: Text("Update Post"),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: scoped.post.title,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: scoped.post.body,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              height: 45,
              child: FlatButton(
                onPressed: (){
                  String title = titleController.text;
                  String body = bodyController.text;
                  scoped.post.title = title;
                  scoped.post.body = body;
                  scoped.apiPostUpdate();
                },
                color: Colors.blue,
                child: Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
