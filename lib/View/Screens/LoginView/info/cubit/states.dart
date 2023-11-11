


abstract class ProfileStates{}

class ProfileInitialState extends ProfileStates {}


class ProfileChangeBottomNavState extends ProfileStates {}

class ProfileLoadingHomeDataState extends ProfileStates {}

class ProfileSuccessHomeDataState extends ProfileStates {}

class ProfileErrorHomeDataState extends ProfileStates {}





class ProfileLoadingGetDataState extends ProfileStates {}

class ProfileLoadingSuccessState extends ProfileStates {}

class ProfileLoadingErrorState extends ProfileStates {}




class ProfileLoadingUpdateDataState extends ProfileStates {}

class ProfileUpdateSuccessState extends ProfileStates {
  final String msg;
  ProfileUpdateSuccessState(this.msg);
}

class ProfileUpdateErrorState extends ProfileStates {
  final String msg;
  ProfileUpdateErrorState(this.msg);
}



class ProfileLoadingDeleteDataState extends ProfileStates {}

class ProfileDeleteSuccessState extends ProfileStates {
  final String msg;
  ProfileDeleteSuccessState(this.msg);
}

class ProfileDeleteErrorState extends ProfileStates {
  final String msg;
  ProfileDeleteErrorState(this.msg);
}






class ProfileLoadingAddDataState extends ProfileStates {}

class ProfileSuccessAddState extends ProfileStates {
  final String msg;
  ProfileSuccessAddState(this.msg);
}

class ProfileErrorAddState extends ProfileStates {
  final String msg;
  ProfileErrorAddState(this.msg);
}
