


abstract class SearchStates{}

class SearchInitialState extends SearchStates {}


class ShopLoadingGetPatientsState extends SearchStates {}

class ShopSuccessGetPatientsState extends SearchStates {
  final String msg;
  ShopSuccessGetPatientsState(this.msg);
}

class ShopErrorGetPatientsState extends SearchStates {
  final String error;
  ShopErrorGetPatientsState(this.error);
}



class ShopLoadingSearchProductState extends SearchStates {}

class ShopSuccessSearchProductState extends SearchStates {
  final String msg;
  ShopSuccessSearchProductState(this.msg);
}

class ShopErrorSearchProductState extends SearchStates {
  final String error;
  ShopErrorSearchProductState(this.error);
}


class ShopSuccessemptySearchProductState extends SearchStates {}





class ShopLoadingCategoryDataState extends SearchStates {}

class ShopSuccessHomeCategoryState extends SearchStates {}

class ShopErrorHomeCategoryState extends SearchStates {}


