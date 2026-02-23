class OnboardingData {
  final String title;
  final String image;

  OnboardingData({required this.title, required this.image});
}

List<OnboardingData> onboardingPages = [
  OnboardingData(
    title: "El Mido will be ready\nto chat and make\nyou happy",
    image: "assets/images/robot3.png",
  ),
  OnboardingData(
    title: "If you are confused\nabout what to do,\njust open El Mido",
    image: "assets/images/robot4.png",
  ),
  OnboardingData(
    title: "Welcome to El Mido,\na great friend to\nchat with you",
    image: "assets/images/robot5.png",
  ),
];
