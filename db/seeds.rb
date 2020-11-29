# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
Article.delete_all
Comment.delete_all

ulist = []
alist = []
clist = []

#seed user
ulist << User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000")

#seed article 
alist << Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, admin_approved: true,  approved: DateTime.new(2020, 11, 04, 03, 00, 00), user_id: 1)

alist << Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, admin_approved: true, approved: DateTime.new(2020, 11, 04, 04, 00, 00), user_id: 1)

alist << Article.create!(company: "Pzifer", industry_type: "Medical", state: "NJ", city: "Newark", compensation: 70000, interview_exp: "Really hard interview", work_exp: "Hands on work. Learned a great deal", upvotes: 0,admin_approved: true,  approved: DateTime.new(2020, 11, 04, 05, 00, 00), user_id: 1)

alist << Article.create!(company: "Pepsico", industry_type: "Food", state: "TX", city: "Houston", compensation: 60000, interview_exp: "Lots of behavioral questions", work_exp: "First time working in the food industry, team was very welcoming", upvotes: 0, admin_approved: true, approved: DateTime.new(2020, 11, 04, 06, 00, 00), user_id: 1)

alist << Article.create!(company: "Goldman Sachs", industry_type: "Finance", state: "NY", city: "New York", compensation: 70000, interview_exp: "Modelling questions. Behavioral questions", work_exp: "Not so good experience, was overworked", upvotes: 0,admin_approved: true,  approved: DateTime.new(2020, 11, 04, 07, 00, 00), user_id: 1)

alist << Article.create!(company: "Business Ink", industry_type: "Business", state: "NY", city: "New York", compensation: 40000, interview_exp: "Logic type of questions", work_exp: "Not really vibing with my team", upvotes: 0,admin_approved: true, approved: DateTime.new(2020, 11, 04, 10,  00, 00), user_id: 1)

#seed comment 
clist << Comment.create!(content: "Horrible, inaccurate post", upvotes: 1, downvotes: 7, user_id: 1, article_id: 1)
clist << Comment.create!(content: "I really think this is wrong", upvotes: 1, downvotes: 7, user_id: 1, article_id: 2)
clist << Comment.create!(content: "I had a good interview tho", upvotes: 1, downvotes: 7, user_id: 1, article_id: 3)
clist << Comment.create!(content: "Nice!! So excited to apply!!", upvotes: 1, downvotes: 7, user_id: 1, article_id: 4)
clist << Comment.create!(content: "I don't think that salary is accurate for NY", upvotes: 1, downvotes: 7, user_id: 1, article_id: 5)
clist << Comment.create!(content: "Please give me a referral...", upvotes: 1, downvotes: 7, user_id: 1, article_id: 6)
