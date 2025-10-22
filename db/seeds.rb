Comment.delete_all
PostTag.delete_all if defined?(PostTag)
Tag.delete_all     if defined?(Tag)
Post.delete_all
User.delete_all

u1 = User.create!(name: "Alice", email: "alice@example.com")
u2 = User.create!(name: "Bob",   email: "bob@example.com")

p1 = Post.create!(title: "Rails API 101", body: "Build fast JSON APIs.", user: u1)
p2 = Post.create!(title: "Associations",  body: "has_many through explained.", user: u2)

Comment.create!(body: "Great post!", user: u2, post: p1)
Comment.create!(body: "Thanks!",     user: u1, post: p1)
Comment.create!(body: "Very clear.", user: u1, post: p2)

if defined?(Tag)
  t1 = Tag.create!(name: "rails")
  t2 = Tag.create!(name: "api")
  t3 = Tag.create!(name: "tutorial")
  p1.tags << [t1, t2]
  p2.tags << [t1, t3]
end
puts "Seeded!"
