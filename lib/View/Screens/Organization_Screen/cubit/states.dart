


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






class DrugLoadingAddDataState extends OrgStates {}

class DrugSuccessAddState extends OrgStates {
  final String msg;
  DrugSuccessAddState(this.msg);
}

class DrugErrorAddState extends OrgStates {
  final String msg;
  DrugErrorAddState(this.msg);
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

