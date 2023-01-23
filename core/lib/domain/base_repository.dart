import 'package:core/usecases/use_case_request.dart';
import 'package:core/usecases/use_case_response.dart';

abstract class BaseRepository {
  Future<BaseResponse> execute(BaseRequest baseRequest);
}