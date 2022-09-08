import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService(this.endPointURL);

  final String endPointURL;

  Future getResponse() async {
    final response = await http.get(Uri.parse(endPointURL));
    print('URL: $endPointURL \n status: ${response.statusCode}');
    print('Response: $response');
    return response.statusCode == 200 ? jsonDecode(response.body) : null;
  }
}
