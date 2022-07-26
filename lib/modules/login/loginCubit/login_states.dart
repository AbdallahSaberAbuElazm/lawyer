abstract class LoginStates {}

class LoginInitialStates extends LoginStates {}

class LoginUserLoadingStates extends LoginStates {}

class LoginUserSuccessStates extends LoginStates {
  final String uID;
  LoginUserSuccessStates(this.uID);
}

class LoginUserErrorStates extends LoginStates {
  final String errMsg;
  LoginUserErrorStates(this.errMsg);
}

class LoginCheckLawyerStatesSuccess extends LoginStates {
  final bool isLawyer;
  LoginCheckLawyerStatesSuccess(this.isLawyer);
}

class LoginCheckLawyerStatesWrong extends LoginStates {
  final bool isLawyer;
  LoginCheckLawyerStatesWrong(this.isLawyer);
}
