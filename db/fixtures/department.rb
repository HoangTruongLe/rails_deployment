department_last = Department.last ? Department.last.id : 0
10.times do |n|
  Department.seed\
    id: department_last + n + 1,
    manager_id: rand(1..5),
    name: Faker::Food.dish
end