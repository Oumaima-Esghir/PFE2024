class Items {
  final String img;
  final String title;
  final String subTitle;
  final String description;

  ///
  Items({
    required this.img,
    required this.title,
    required this.subTitle,
    required this.description,
  });
}

List<Items> listOfItems = [
  Items(
      img: "assets/images/onboarding.jpg",
      title: "Welcome To Our App",
      subTitle: "DealDiscover",
      description:
          "Your ultimate destination for discovering the best deals and offers tailored just for you! "
          "Whether you're searching for exciting discounts at your favorite restaurants, exclusive promotions,"
          "or amazing deals on travel experiences,our app has got you covered. "),
  Items(
      img: "assets/images/on2.jpg",
      title: "Welcome To Our App",
      subTitle: "DealDiscover",
      description:
          "Your ultimate destination for discovering the best deals and offers tailored just for you! "
          "Whether you're searching for exciting discounts at your favorite restaurants, exclusive promotions,"
          "or amazing deals on travel experiences,our app has got you covered. "),
  Items(
      img: "assets/images/on3.jpg",
      title: "Welcome To Our App",
      subTitle: "DealDiscover",
      description:
          "Your ultimate destination for discovering the best deals and offers tailored just for you! "
          "Whether you're searching for exciting discounts at your favorite restaurants, exclusive promotions,"
          "or amazing deals on travel experiences,our app has got you covered. "),
];
