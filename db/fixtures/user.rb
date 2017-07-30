user_last = User.last ? User.last.id : 0
30.times do |n|
  User.seed\
    id: user_last + n + 1,
    email: "guest" + (user_last + n + 1).to_s + "@gmail.com",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: '123456',
    position: [:Manager, :Comter, :HR, :Account, :QC, :Submanager, :Developer].sample,
    role: [:admin, :user].sample,
    birth_date: rand(20.years).seconds.ago,
    gender: [:male, :female].sample,
    join_date: rand(1.years).seconds.ago,
    remaining_days_off: 15.0,
    department_id: rand(1..4)
end
