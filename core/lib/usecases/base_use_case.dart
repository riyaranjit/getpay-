import 'package:core/usecases/use_case_request.dart';
import 'package:core/usecases/use_case_response.dart';

abstract class BaseUseCase<I extends BaseRequest,
    O extends BaseResponse> {
  Future<O> execute(I param);
}
