User.seed\
    id: 1,
    email: "guest1@gmail.com",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: '123456',
    position: [:Manager, :Comter, :HR, :Account, :QC, :Submanager, :Developer].sample,
    role: [:admin, :user].sample,
    birth_date: rand(40.years).seconds.ago,
    gender: [:male, :female].sample,
    join_date: rand(1.years).seconds.ago,
    remaining_days_off: 15.0,
    department_id: rand(1..4)

request_off = RequestOff.last ? RequestOff.last.id : 0
user_first = User.first ? User.first.id : 0
user_last = User.last ? User.last.id : 0
30.times do |n|
  RequestOff.seed\
    id: request_off + n + 1,
    time_start: rand(3.days).seconds.ago,
    time_end: rand(3.days).seconds.from_now,
    reason: Faker::HarryPotter.quote,
    status: "pending",
    user_id: User.find_by(id: rand((user_first)..(user_last))) ?  (user_first) : (user_last),
    total_hours: 9.0
end