abstract class AppState {}
class LoginInitial extends AppState {}
class LoginSingeUpState extends AppState {}
class LoginCreateDatabaseState extends AppState {}



class LoginLoadingState extends AppState {}
class LoginSuccessState extends AppState {}
class LoginFailureState extends AppState {
  final String error;
  LoginFailureState({required this.error});
}
class AuthLoading extends AppState {}
class AuthSuccess extends AppState {}
class AuthFailure extends AppState {
  final String error;
  AuthFailure({required this.error});
}


class AppCreateDatabaseState extends AppState{}

class AppGetDatabaseState extends AppState{}

class AppGetDatabaseLoadingState extends AppState{}

class AppInsertDatabaseState extends AppState{}

class AppUpdateDatabaseState extends AppState{}

class AppDeleteDatabaseState extends AppState{}

class AppSearchDatabaseState extends AppState{}

class InitializeNotificationState extends AppState{}
class SetTimeNotificationState extends AppState{}
class ScheduledNotificationState extends AppState{}
class CancelNotificationState extends AppState{}
class CancelAllNotificationState extends AppState{}
class ShowNotificationState extends AppState{}
class RequestIOSPermissionState extends AppState{}
class OnSelectNotificationState extends AppState{}
class UserLoginLoadingState extends AppState{}
class UserLoginSuccessState extends AppState{}
class UserLoginFailureState extends AppState{
  final String error;
  UserLoginFailureState({required this.error});
}
class DetectEmotionSmileState extends AppState{}
class DetectEmotionSmileSuccessState extends AppState{}
class DetectEmotionSmileFailureState extends AppState{
  final String error;
  DetectEmotionSmileFailureState({required this.error});
}
