News Reader App
A Flutter-based News Reader app that fetches and displays news articles from a public API (NewsAPI.org) using Clean Architecture, BLoC for state management, and get_it for Dependency Injection. The app includes a responsive UI, pagination, and proper error handling.
Features

News List Page: Displays a list of news articles with titles, publication dates, and thumbnail images in a card-based layout.
News Detail Page: Shows detailed information for a selected article, including a larger image, title, publication date, and description.
API Integration: Fetches news articles from NewsAPI.org.
Clean Architecture: Separates concerns into Data, Domain, and Presentation layers.
State Management: Uses flutter_bloc for robust state management.
Dependency Injection: Implements DI using get_it for modularity.
Error Handling: Handles failures (server and network) using dartz's Either.
Pagination: Loads additional articles when scrolling to the end of the list.
Image Caching: Uses cached_network_image for efficient image loading.


