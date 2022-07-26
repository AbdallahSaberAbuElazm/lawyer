abstract class RegisterStates {}

class RegisterInitialStates extends RegisterStates {}

class RegisterCehckConfirmStates extends RegisterStates {}

class changeAccepteStates extends RegisterStates {}

class RegisterUserLoadingStates extends RegisterStates {}

class RegisterUserSuccessStates extends RegisterStates {}

class RegisterUserErrorStates extends RegisterStates {
  final String errMsg;
  RegisterUserErrorStates(this.errMsg);
}

class CreateUserSuccessfullStates extends RegisterStates {}

class CreateUserErrorStates extends RegisterStates {}



class RegisterLawyerLoadingStates extends RegisterStates {}

class RegisterLawyerSuccessStates extends RegisterStates {}

class RegisterLawyerErrorStates extends RegisterStates {
    final String errMsg;
  RegisterLawyerErrorStates(this.errMsg);
}

class CreateLawyerSuccessfullStates extends RegisterStates {}

class CreateLawyerErrorStates extends RegisterStates {}




class RegisterLawyerAddFileStates extends RegisterStates{}


class RegisterLawyerPickFileSuccessStates extends RegisterStates {}

class RegisterLawyerUploadSuccessStates extends RegisterStates{}
