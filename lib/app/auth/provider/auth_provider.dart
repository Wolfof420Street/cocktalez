import 'package:cocktalez/app/auth/data/model/login_model.dart';
import 'package:cocktalez/app/auth/data/service/auth_service.dart';
import 'package:cocktalez/app/auth/utils/sign_up_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/login_utils.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authUtilsProvider = Provider<SignUpUtils>((ref) => SignUpUtils());

final loginUtilsProvider = Provider<LoginUtils>((ref) => LoginUtils());

final signUpController = FutureProviderFamily<dynamic, LoginModel>(
    (ref, arg) => ref
        .read(authServiceProvider)
        .createUserWithEmailAndPassword(arg.email, arg.password));

final loginController = FutureProviderFamily<dynamic, LoginModel>((ref, arg) =>
    ref
        .read(authServiceProvider)
        .signInWithEmailAndPassword(arg.email, arg.password));