


abstract class DrugStates{}

class DrugInitialState extends DrugStates {}


class DrugChangeBottomNavState extends DrugStates {}

class DrugLoadingHomeDataState extends DrugStates {}

class DrugSuccessHomeDataState extends DrugStates {}

class DrugErrorHomeDataState extends DrugStates {}





class DrugLoadingGetDataState extends DrugStates {}

class DrugLoadingSuccessState extends DrugStates {}

class DrugLoadingErrorState extends DrugStates {}




class DrugLoadingDeleteDataState extends DrugStates {}

class DrugDeleteSuccessState extends DrugStates {
  final String msg;
  DrugDeleteSuccessState(this.msg);
}

class DrugDeleteErrorState extends DrugStates {
  final String msg;
  DrugDeleteErrorState(this.msg);
}






class DrugLoadingAddDataState extends DrugStates {}

class DrugSuccessAddState extends DrugStates {
  final String msg;
  DrugSuccessAddState(this.msg);
}

class DrugErrorAddState extends DrugStates {
  final String msg;
  DrugErrorAddState(this.msg);
}
