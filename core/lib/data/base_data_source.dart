import 'package:core/usecases/use_case_request.dart';
import 'package:core/usecases/use_case_response.dart';

abstract class BaseDataSource {
  Future<BaseResponse> execute(BaseRequest baseRequest);
}