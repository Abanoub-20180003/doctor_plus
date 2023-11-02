


abstract class ReportStates{}

class ReportInitialState extends ReportStates {}


class ReportChangeBottomNavState extends ReportStates {}

class ReportLoadingHomeDataState extends ReportStates {}

class ReportSuccessHomeDataState extends ReportStates {}

class ReportErrorHomeDataState extends ReportStates {}





class DrugLoadingGetDataState extends ReportStates {}

class DrugLoadingSuccessState extends ReportStates {}

class DrugLoadingErrorState extends ReportStates {}




// class DrugLoadingDeleteDataState extends DrugStates {}
//
// class DrugDeleteSuccessState extends DrugStates {
//   final String msg;
//   DrugDeleteSuccessState(this.msg);
// }
//
// class DrugDeleteErrorState extends DrugStates {
//   final String msg;
//   DrugDeleteErrorState(this.msg);
// }
//


