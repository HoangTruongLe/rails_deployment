# Migration Department
Department.create(name: 'S1')
Department.create(name: 'S2')

# Migration User
email = ['ha.nt@neo-lab.vn','thieu.lq@neo-lab.vn', 'thanh.n@neo-lab.vn', 'huynh.th@neo-lab.vn', 'chi.ptk@neo-lab.vn', 'tomoshige.k@neo-lab.vn', 'khanh.tv@neo-lab.vn', 'loi.vd@neo-lab.vn',
         'giang.nh@neo-lab.vn', 'son.nh@neo-lab.vn', 'thuan.nv@neo-lab.vn', 'an.ph@neo-lab.vn', 'tien.nv@neo-lab.vn', 'thang.ng@neo-lab.vn', 'chinh.nvb@neo-lab.vn', 'nhan.nt@neo-lab.vn',
					'vu.tq@neo-lab.vn', 'hai.nn@neo-lab.vn', 'diep.pn@neo-lab.vn', 'truong.lh@neo-lab.vn', 'tin.hq@neo-lab.vn', 'dong.n@neo-lab.vn',
				 'quan.ld@neo-lab.vn', 'nam.th@neo-lab.vn', 'em.tvs@neo-lab.vn']
firstname= ['Hà', 'Thiều', 'Thanh', 'Huynh', 'Chi', 'Tomoshige', 'Khánh', 'Lợi', 'Giang', 'Sơn', 'Thuận', 'Ân', 'Tiến', 'Thắng', 'Chinh', 'Nhân', 'Vũ', 'Hải', 'Ngọc Điệp',
            'Trưởng', 'Tín', 'Đồng', 'Quân', 'Nam', 'Em']
lastname = ['Nguyễn Thu', 'Lê Quang', 'Nguyễn', 'Trần Hoàng', 'Phù Thị Kim', 'Kimura', 'Nguyễn Văn', 'Võ Đức', 'Nguyễn Hoàng', 'Nguyễn Hoàng', 'Nguyễn Văn', 'Phạm Hồng',
            'Nguyễn Văn', 'Nguyễn Gia', 'Nguyễn Văn Bảo', 'Nguyễn Trọng', 'Trần Quang', 'Nguyễn Ngọc', 'Phù Thị', 'Lê Hoàng', 'Huỳnh Quốc', 'Nguyễn',
						'Lê Duy', 'Trương Hoài', 'Thái Văn Sĩ']
position = ['accountant', 'manager', 'manager', 'developer', 'comtor', 'manager', 'comtor', 'developer', 'developer', 'developer', 'developer', 'developer', 'developer', 'developer',
            'developer', 'developer', 'developer', 'developer', 'hr', 'developer', 'developer', 'developer', 'developer', 'developer', 'developer']
role = ['admin', 'admin', 'admin', 'employee', 'employee', 'employee', 'employee', 'employee', 'employee', 'employee', 'employee', 'employee', 'employee', 'employee',
        'employee', 'employee', 'employee', 'employee', 'admin', 'employee', 'employee', 'employee', 'employee', 'employee', 'employee']

birthday = ['1986-09-24', '1989-01-01', '1989-02-02', '1990-09-24', '1992-09-29', '1989-09-23', '1989-12-01', '1989-05-16', '1991-11-18', '1991-09-21', '1992-10-20', '1994-01-22', '1991-09-24', '1993-10-15', '1992-03-03',
            '1997-01-23', '1989-03-01', '1986-03-27', '1990-05-09', '1991-04-01', '1992-02-16', '1990-07-25', '1992-02-15', '1991-10-14', '1987-03-02']
gender = ['Female', 'Male', 'Male', 'Male', 'Female', 'Male', 'Male', 'Male', 'Male', 'Male', 'Male', 'Male', 'Male', 'Male', 'Male', 'Male', 'Male', 'Female', 'Male', 'Male', 'Male', 'Male', 'Male', 'Male', 'Male']
join_date =['2016-02-01', '2016-09-01', '2016-09-12', '2016-09-01', '2016-09-06', '2017-01-03', '2016-02-01', '2016-10-03', '2016-11-14', '2016-12-19', '2017-01-03', '2017-01-04', '2017-01-16', '2017-02-06', '2017-02-06', '2017-02-06',
            '2017-02-06', '2017-02-06', '2017-03-01', '2017-03-06', '2017-04-03', '2017-04-03', '2017-04-03', '2017-04-03', '2017-04-04']

email.length.times do |f|
	p "Inserting user #{email[f]}"
  User.create!(email: email[f], first_name: firstname[f], \
               last_name: lastname[f], position: position[f], role: role[f], \
               birth_date: birthday[f], gender: gender[f], join_date: join_date[f], \
               password: '123456', department_id: Department.first.id, chatwork_id: '1')
end

# Migration request off
unless Rails.env.production?
	100.times do |n|
		p "Inserting requestoff #{n}"
		RequestOff.create!(
			time_start: rand(3.days).seconds.ago,
			time_end: rand(3.days).seconds.from_now,
			reason: Faker::HarryPotter.quote,
			status: "waiting",
			user_id: rand(1..email.length),
			total_hours: rand(1..18),
			status_update_by: 1
		)
	end
end