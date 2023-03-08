import '../models/models.dart';

List<T2Favourite> getFavourites() {
  List<T2Favourite> list = [];
  T2Favourite model1 = T2Favourite();
  model1.name = "Best Jogging tips in the world";
  model1.duration = "5 min ago";
  model1.image = 'images/login/vnat.png';

  list.add(model1);
  return list;
}

List<T2Slider> getSliders() {
  List<T2Slider> list = [];
  T2Slider model1 = T2Slider();
  model1.title = 'title';
  model1.subTitle = 'subtitle';
  model1.image = 'images/login/vnat.png';

  list.add(model1);

  return list;
}

List<T2ListModel> getListData() {
  List<T2ListModel> mData = [];

  T2ListModel model1 = T2ListModel();
  model1.name = "Flower Tips";
  model1.duration = "12 min ago";
  model1.description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text.";
  model1.type = "New";
  model1.icon = 'images/login/vnat.png';

  mData.add(model1);
  return mData;
}
