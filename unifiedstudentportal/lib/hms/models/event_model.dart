class Event {
  String name;
  String description;
  DateTime eventDate;
  String image;
  String location;
  String organizer;
  num price;

  Event({
    required this.eventDate,
    required this.image,
    required this.location,
    required this.name,
    required this.organizer,
    required this.price,
    required this.description,
  });
}

final List<Event> upcomingEvents = [
  Event(
    name: "Emerging Technologies \n for Intelligent Systems (ETIS 2025)",
    eventDate: DateTime.now().add(const Duration(days: 24)),
    image: 'https://source.unsplash.com/800x600/?concert',
    description: "ETIS 2025 is a significant event focusing on emerging technologies, including cybersecurity and ethical hacking. The conference aims to bring together researchers, practitioners, and industry experts to discuss advancements and challenges in intelligent systems",
    location: "Kozhikode",
    organizer: "KTU",
    price: 130,
  ),

  Event(
    name: "Cyber Security \n and Privacy",
    eventDate: DateTime.now().add(const Duration(days: 33)),
    image: 'https://source.unsplash.com/800x600/?band',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: " Government Engineering College Thrissur",
    organizer: "KTU",
    price: 250,
  ),
  Event(
    name: "AI and ML workshop",
    eventDate: DateTime.now().add(const Duration(days: 12)),
    image: 'https://source.unsplash.com/800x600/?music',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "College of Engineering Vadakara",
    organizer: "KTU",
    price: 100,
  ),
];


final List<Event> nearbyEvents = [
  Event(
    name: "Emerging Technologies for Intelligent Systems (ETIS 2025)",
    eventDate: DateTime.now().add(const Duration(days: 1)),
    image: 'https://source.unsplash.com/600x800/?concert',
    description: "ETIS 2025 is a significant event focusing on emerging technologies, including cybersecurity and ethical hacking. The conference aims to bring together researchers, practitioners, and industry experts to discuss advancements and challenges in intelligent systems",
    location: "Kozhikode",
    organizer: "KTU",
    price: 130,
  ),
  Event(
    name: "Cyber Security and Privacy",
    eventDate: DateTime.now().add(const Duration(days: 4)),
    image: 'https://source.unsplash.com/600x800/?live',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "Government Engineering College Thrissur",
    organizer: " KTU",
    price: 250,
  ),
  Event(
    name: "AI and ML workshop",
    eventDate: DateTime.now().add(const Duration(days: 2)),
    image: 'https://source.unsplash.com/600x800/?orchestra',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "College of Engineering Vadakara",
    organizer: "kTU",
    price: 100,
  ),
  Event(
    name: "Master's Program in Information and Information Technology Security",
    eventDate: DateTime.now().add(const Duration(days: 21)),
    image: 'https://source.unsplash.com/600x800/?music',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "Trivandrum",
    organizer: "KTU",
    price: 0,
  ),
  Event(
    name: "International Conference on Information and Software Technologies (ICIST 2025)",
    eventDate: DateTime.now().add(const Duration(days: 16)),
    image: 'https://source.unsplash.com/600x800/?rock_music',
    description: "The pretty reckless is an American rock band from New york city, Formed in 2009. The",
    location: "Kochi",
    organizer: "KTU",
    price: 14,
  ),
];
