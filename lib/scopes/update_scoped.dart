import 'package:patterns_scoped/model/post_model.dart';
import 'package:patterns_scoped/service/http_service.dart';
import 'package:scoped_model/scoped_model.dart';

class UpdateScoped extends Model{
  var isLoading = false;
  var post = Post();

  Future<bool> apiPostUpdate() async {
    isLoading = true;
    notifyListeners();

    var response = await NetWork.PUT(NetWork.API_UPDATE + post.id.toString(), NetWork.paramsUpdate(post));
    // print("Response: $response");
    isLoading = false;
    notifyListeners();

    return response != null;
  }
}