const BASE_URL = 'https://restaurant-api.dicoding.dev/';

const ENDPOINT_ALL_RESTAURANT = '${BASE_URL}list';

String restaurantDetailEndpoint(restaurantId) =>
    '${BASE_URL}detail/$restaurantId';

String searchRestaurantEndpoint(query) => '${BASE_URL}search?q=$query';
