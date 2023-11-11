


abstract class ShopStates{}

class ShopInitialState extends ShopStates {}


class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}


class AppLoadingLoginHomeState extends ShopStates {}

class AppSuccessLoginDataState extends ShopStates {
  final String msg;
  AppSuccessLoginDataState(this.msg);
}

class AppErrorLoginDataState extends ShopStates {
  final String msg;
  AppErrorLoginDataState(this.msg);
}




class ShopLoadingCategoryDataState extends ShopStates {}

class ShopSuccessHomeCategoryState extends ShopStates {}

class ShopErrorHomeCategoryState extends ShopStates {}



class ShopLoadingFavState extends ShopStates {}

class ShopSuccessHomeFavState extends ShopStates {

}

class ShopErrorHomeFavState extends ShopStates {}



class ShopLoadingGetFavState extends ShopStates {}

class ShopSuccessGetFavState extends ShopStates {
  // final FavModel2 model2;
  // ShopSuccessGetFavState(this.model2);
}

class ShopErrorGetFavState extends ShopStates {}











class ShopLoadingGetDataProductsByCategoryState extends ShopStates {}

class ShopSuccessGetDataProductsByCategoryState extends ShopStates {
  //final SearchModel user;
  //ShopSuccessGetDataProductsByCategoryState(this.user);
}

class ShopErrorGetDataProductsByCategoryState extends ShopStates {}














class ShopLoadingUpdateProfileState extends ShopStates {}

class ShopSuccessUpdateProfileState extends ShopStates {

}

class ShopErrorUpdateProfileState extends ShopStates {}





class AppChangeBottomSheetState extends ShopStates{}


//
// class NewsGetBusinessSuccessState extends ShopStates {}
//
// class NewsGetBusinessErrorState extends ShopStates
// {
//   final String error;
//   NewsGetBusinessErrorState(this.error);
// }



class ShopProductIntialState extends ShopStates {}

class ShopLoadingGetProductDetailState extends ShopStates {}

class ShopSuccessGetProductDetailState extends ShopStates {

}

class ShopErrorGetProductDetailState extends ShopStates {}


