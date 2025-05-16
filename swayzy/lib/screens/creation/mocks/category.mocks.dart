import '../../../constants/app_images_paths.dart';
import '../models/category.dart';

final List<Category> appCategories = [
  Category(
    title: "Electronics",
    pathToImage: AppImagesPaths.categoryMockElectronics,
  ),
  Category(title: "Services", pathToImage: AppImagesPaths.categoryMockServices),
  Category(
    title: "Vehicles",
    pathToImage: AppImagesPaths.categoryMockAutomobiles,
  ),
  Category(title: "Clothes", pathToImage: AppImagesPaths.categoryMockClothes),
];
