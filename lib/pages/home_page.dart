import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patterns_scoped/model/post_model.dart';
import 'package:patterns_scoped/pages/create_page.dart';
import 'package:patterns_scoped/pages/update_page.dart';
import 'package:patterns_scoped/scopes/home_scoped.dart';
import 'package:scoped_model/scoped_model.dart';


class HomePage extends StatefulWidget {
  static final String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    HomeScoped scoped = HomeScoped();

  void _apiPostUpdate(Post post) async {
   var result  = await Navigator.pushNamed(context, UpdatePage.id, arguments: {"id": post.id, "title": post.title, "body": post.body, "userId": post.userId});
   if(result != null) {
     var done = (result as Map)["data"];
     if (done == "done") {
       setState(() {
         scoped.apiPostList();
       });
     }
   }
  }

  @override
  void initState() {
    super.initState();
    scoped.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Scoped Model"),
        ),
      ),
      body: ScopedModel<HomeScoped>(
        model: scoped,
        child: ScopedModelDescendant<HomeScoped>(
          builder: (context,child,model){
            return Stack(
              children: [
                ListView.builder(
                    itemCount: scoped.items.length ,
                    itemBuilder: (ctx, index){
                      return itemOfPost(scoped.items[index]);
                    }
                ),
                scoped.isLoading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          setState(() {
            Navigator.pushNamed(context, CreatePage.id);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPost(Post post){
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title.toUpperCase(),
              style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(post.body),
          ],
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: "Update",
          color: Colors.indigo,
          icon: Icons.edit,
          onTap: (){
            _apiPostUpdate(post);
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: "Delete",
          color: Colors.red,
          icon: Icons.delete,
          onTap: (){
            scoped.apiPostDelete(post).then((value) => {
              if (value) scoped.apiPostList(),
            });
          },
        )
      ],
    );
  }

}
