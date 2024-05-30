abstract class EndPoints {

  static const String register = "/register";
  static const String login = "/login";

  static const String places = "/place/page";

  static const String createcomment = "/comments";
  static const String deletecomment = "/comments/:id";

  static const String createrates = "/rates";
  static const String getrates = "/rates/page";

  static String queryPath(String endPoint, List<String> args) {
    String result = endPoint;
    for (var i = 0; i < args.length; i++) {
      result = result.replaceAll('<${i + 1}>', args[i]);
    }
    print("query path : " + result);
    return result;
  }

  static String getRates(String placeId) {
    return "$getrates?rated_id=$placeId";
  }
}
