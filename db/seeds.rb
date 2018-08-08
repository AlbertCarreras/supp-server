include ActionView::Helpers::NumberHelper

# User.delete_all
InterestCategory.delete_all

hiking = InterestCategory.create(name: "Hiking")
boardgames = InterestCategory.create(name: "Board Games")

# user1 = User.create(
#     username: "Alberto",
#     email: "albertcarreras@hotmail.com",
#     date_of_birth: Date.strptime("1985/07/04", "%Y/%m/%d"),
#     bio: "My name is Alberto, and I like board games.",
#     interest_categories: [hiking, boardgames],
#     last_location_lat: number_with_precision(40.704742599999996, precision: 15),
#     last_location_lon: number_with_precision(-74.01364319999999, precision: 15),
#     # last_location_lat: 40.704742599999996,
#     # last_location_lon: -74.01364319999999,
#     last_zipcode: 11221,
#     active_user: true,
#   )