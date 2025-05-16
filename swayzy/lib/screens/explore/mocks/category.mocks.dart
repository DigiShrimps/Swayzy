import '../../../constants/app_images_paths.dart';
import '../../explore/models/category.dart';

final List<Category> orderCategories = [
  Category(title: "All category", pathToImage: AppImagesPaths.categoryMockAll, id: "all"),
  Category(title: "Electronics", pathToImage: AppImagesPaths.categoryMockElectronics, id: "Electronics"),
  Category(title: "Services", pathToImage: AppImagesPaths.categoryMockServices, id: "Services"),
  Category(title: "Vehicles", pathToImage: AppImagesPaths.categoryMockAutomobiles, id: "Vehicles"),
  Category(title: "Clothes", pathToImage: AppImagesPaths.categoryMockClothes, id: "Clothes"),
];
