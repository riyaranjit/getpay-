import 'package:dynamic_form/form/validation_rule.dart';

abstract class BaseFieldState {
  void validateField<T>(ValidationRule validationRule, T data);
}
