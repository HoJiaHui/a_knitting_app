class Category {
  final String name;
  final int numOfCourses;
  final String image;

  Category(this.name, this.numOfCourses, this.image);
}

List<Category> categories = categoriesData
    .map((item) => Category(item['name'], item['courses'], item['image']))
    .toList();

var categoriesData = [
  {"name": "", 'courses': 17, 'image': "assets/images/baby.png"},
  {"name": "Harry Potter Scraf", 'courses': 25, 'image': "assets/images/harrypotter.png"},
  {
    "name": "A Raglan Sleeve Sweater",
    'courses': 13,
    'image': "assets/images/shirt.png"
  },
  {"name": "Hat", 'courses': 17, 'image': "assets/images/hat.png"},
];