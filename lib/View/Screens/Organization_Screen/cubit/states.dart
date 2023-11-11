


import 'package:doctor_plus/Model/patient.dart';

import '../../../../Model/doctor.dart';

abstract class OrgStates{}

class OrgInitialState extends OrgStates {}


class DrugChangeBottomNavState extends OrgStates {}

class DrugLoadingHomeDataState extends OrgStates {}

class DrugSuccessHomeDataState extends OrgStates {}

class DrugErrorHomeDataState extends OrgStates {}





class DrugLoadingGetDataState extends OrgStates {}

class DrugLoadingSuccessState extends OrgStates {}

class DrugLoadingErrorState extends OrgStates {}


class OrgLoadingGetDataState extends OrgStates {}

class OrgLoadingSuccessState extends OrgStates {}

class OrgLoadingErrorState extends OrgStates {}



class DrugLoadingDeleteDataState extends OrgStates {}

class DrugDeleteSuccessState extends OrgStates {
  final String msg;
  DrugDeleteSuccessState(this.msg);
}

class DrugDeleteErrorState extends OrgStates {
  final String msg;
  DrugDeleteErrorState(this.msg);
}





class DrugLoadingProfilePatientDataState extends OrgStates {}

class DrugProfilePatientSuccessState extends OrgStates {
  final Patient? patient_detail;
  DrugProfilePatientSuccessState(this.patient_detail);
}

class DrugProfilePatientErrorState extends OrgStates {
  final String msg;
  DrugProfilePatientErrorState(this.msg);
}







class OrganizationLoadingAddDataState extends OrgStates {}

class OrganizationSuccessAddState extends OrgStates {
  final String msg;
  OrganizationSuccessAddState(this.msg);
}

class OrganizationErrorAddState extends OrgStates {
  final String msg;
  OrganizationErrorAddState(this.msg);
}



class ShopLoadingSearchDrugState extends OrgStates {}

class ShopSuccessSearchDrugState extends OrgStates {
  final String msg;
  ShopSuccessSearchDrugState(this.msg);
}

class ShopErrorSearchDrugState extends OrgStates {
  final String error;
  ShopErrorSearchDrugState(this.error);
}


class ShopSuccessemptySearchDrugState extends OrgStates {}

class GetDoctorLoadingDataState extends OrgStates {}

class GetDoctorSuccessDataState extends OrgStates {
  final Doctor? doc;
  final String msg;
  final bool unique;
  final bool found;
  GetDoctorSuccessDataState(this.doc,this.unique,this.found,this.msg);
}

class GetDoctorErrorDataState extends OrgStates {
  final String msg;
  GetDoctorErrorDataState(this.msg);
}




class AssignDoctorLoadingDataState extends OrgStates {}

class AssignDoctorSuccessDataState extends OrgStates {
  final bool status;
  final String msg;
  AssignDoctorSuccessDataState(this.status,this.msg);
}

class AssignDoctorErrorDataState extends OrgStates {
  final String msg;
  AssignDoctorErrorDataState(this.msg);
}