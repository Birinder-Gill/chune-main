import 'package:cloud_functions/cloud_functions.dart';

import '../models/chune.dart';

class CloudFunctionsService {
  FirebaseFunctions functions = FirebaseFunctions.instance;

  Future addChune(Chune chune) async {
    final data = await _callFunction('addChune', data: chune.toMap());
    print(data);
  }

  Future likeChune(String chuneId) async {
    final data =
        await _callFunction('likeChune', data: <String, String>{'id': chuneId});
  }

  Future listenChune(String chuneId) async {
    final data =
        await _callFunction('listenChune', data: <String, String>{'id': chuneId});
  }

  Future unlikeChune(String chuneId) async {
    final data = await _callFunction('unlikeChune',
        data: <String, String>{'id': chuneId});
  }

  Future followUser(String userId) async {
    print(userId);
    final data =
        await _callFunction('followUser', data: <String, String>{'id': userId});
    print(data);
  }

  Future unfollowUser(String userId) async {
    final data = await _callFunction('unfollowUser',
        data: <String, String>{'id': userId});
  }

  Future _callFunction(String functionName, {Map data}) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('$functionName');
    final results = await callable(data ?? {});
    print(results.data);
    return results.data;
  }

  void sendNotification() async{
    final data = await _callFunction('showNotification');
    print(data);

  }
}
