
User.delete_all
user1 = User.create(
    username: "Alberto",
    email: "albertcarreras@hotmail.com",
    date_of_birth: Date.strptime("1985/07/04", "%Y/%m/%d"),
    bio: "My name is Alberto, and I like board games.",
  )