User.destroy_all
Card.destroy_all
Bill.destroy_all

user01 = User.new({
  :name => "Clovis",
  :email => "clovis@mail.com",
  :avatar_url => "https://imgur.com/gallery/HCfou5y",
})

user02 = User.new({
  :name => "Basilio",
  :email => "basilio@mail.com",
  :avatar_url => "https://imgur.com/gallery/HCfou5y",
})

user01.save!
user02.save!

card01 = Card.new({
  :number => "5148101366735700",
  :name => "Clovis",
  :limit => "300",
  :logo_url => "https://imgur.com/gallery/CbmR8",
})

card02 = Card.new({
  :number => "5112451366735700",
  :name => "Basilio",
  :limit => "400",
  :logo_url => "https://imgur.com/gallery/CbmR8",
})

card01.save!
card02.save!

bill01 = Bill.new({
  :value => 109.23,
  :expire_date => 1.year.from_now,
})

bill02 = Bill.new({
  :value => 909.23,
  :expire_date => 1.year.ago,
})

bill01.save!
bill02.save!

user01.cards << card01
user02.cards << card02
user01.save!
user02.save!

card01.bills << bill01
card02.bills << bill02
card01.save!
card02.save!