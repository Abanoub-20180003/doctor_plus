


abstract class ReportStates{}

class ReportInitialState extends ReportStates {}


//class ReportChangeBottomNavState extends ReportStates {}

class ReportLoadingHomeDataState extends ReportStates {}

class ReportSuccessHomeDataState extends ReportStates {}

class ReportErrorHomeDataState extends ReportStates {}





class DrugLoadingGetDataState extends ReportStates {}

class DrugLoadingSuccessState extends ReportStates {}

class DrugLoadingErrorState extends ReportStates {}


class Test_Type_AddDataState extends ReportStates {}

class Test_Type_AddSuccessState extends ReportStates {
  final String msg;
  Test_Type_AddSuccessState(this.msg);
}

class Test_Type_AddErrorState extends ReportStates {
  final String msg;
  Test_Type_AddErrorState(this.msg);
}




class Test_Type_LoadingDeleteDataState extends ReportStates {}

class Test_Type_DeleteSuccessState extends ReportStates {
  final String msg;
  Test_Type_DeleteSuccessState(this.msg);
}

class Test_Type_DeleteErrorState extends ReportStates {
  final String msg;
  Test_Type_DeleteErrorState(this.msg);
}


class ShopLoadingSearchMedicalTestState extends ReportStates {}

class ShopSuccessSearchMedicalTestState extends ReportStates {
  final String msg;
  ShopSuccessSearchMedicalTestState(this.msg);
}

class ShopErrorSearchMedicalTestState extends ReportStates {
  final String msg;
  ShopErrorSearchMedicalTestState(this.msg);
}

class ShopSuccessemptySearchMedicalTestState extends ReportStates {}


