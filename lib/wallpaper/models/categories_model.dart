class CategorieModel {
  String title;
  String imageUrl;

  CategorieModel({
    this.title,
    this.imageUrl,
  });
}

List<CategorieModel> getCategories = [
  CategorieModel(
    imageUrl:
        "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    title: "Street Art",
  ),
  CategorieModel(
    imageUrl:
        "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    title: "Wild Life",
  ),
  CategorieModel(
    imageUrl:
        "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    title: "Nature",
  ),
  CategorieModel(
    imageUrl:
        "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    title: "City",
  ),
  CategorieModel(
    imageUrl:
        "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260",
    title: "Motivation",
  ),
  CategorieModel(
    imageUrl:
        "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    title: "Bikes",
  ),
  CategorieModel(
    imageUrl:
        "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
    title: "Cars",
  ),
];
