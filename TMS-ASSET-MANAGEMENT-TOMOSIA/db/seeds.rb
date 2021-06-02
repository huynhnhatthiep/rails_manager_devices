User.create!(name: "name user",
    email: "example@gmail.com", password:"123456", password_confirmation: "123456", role: 2, phone_number: '0123456789', project_id: 1, created_at: Time.zone.now, updated_at: Time.zone.now)
  10.times do |n|
    name = Faker::Name.name
    email = "examples-#{n+1}@gmail.com"
    password = "password"
    role = Random.rand(0..2)
    phone_number = Faker::PhoneNumber.phone_number
    project_id = 1
    User.create!(
      name: name,
      email: email,
      password:password,
      password_confirmation: password,
      role: role, phone_number: phone_number,
      project_id: project_id,
      created_at: Time.zone.now,
      updated_at: Time.zone.now
    )
  end

  Item.create!(name: "name user",
    status: 1, comment: "hang chat luong", price: 900, detail: {CPU: "Intel Core i7-9th-gen", RAM: "16 GB, DDR4, 2666 MHz", Screen: "16.0\", 3072 x 1920 Pixel, IPS, IPS LCD LED Backlit, True Tone", Graphics: "SSD 512 GB", HardDrive: "AMD Radeon Pro 5300M 4 GB \u0026 Intel UHD Graphics 630",Dimensions: "Mac OS",year: "2021"}, category_id: 1, created_at: Time.zone.now, updated_at: Time.zone.now)
  40.times do |n|
    name = Faker::Name.name
    status = Random.rand(0..2)
    price = 900
    detail = {CPU: "Intel Core i7-9th-gen", RAM: "16 GB, DDR4, 2666 MHz", Screen: "16.0\", 3072 x 1920 Pixel, IPS, IPS LCD LED Backlit, True Tone", Graphics: "SSD 512 GB", HardDrive: "AMD Radeon Pro 5300M 4 GB \u0026 Intel UHD Graphics 630",Dimensions: "Mac OS",year: "2021"}
    category_id = Random.rand(1..10)
    Item.create!(
      name: name,
      status: status,
      price: price,
      detail: detail,
      category_id: category_id,
      created_at: Time.zone.now,
      updated_at: Time.zone.now
    )
  end
