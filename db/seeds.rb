# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean maximus lacinia felis id fermentum. Mauris at euismod tellus, quis semper diam. In ac est purus. Vivamus placerat nulla at porttitor aliquet. Aenean ut euismod velit. Vestibulum sed lectus mi. Nam ultricies lacinia nibh eu viverra. Sed eu nisl ac elit malesuada ornare eget eu mauris. In hac habitasse platea dictumst. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent ullamcorper porttitor velit,
      ut gravida felis cursus in. Donec imperdiet dignissim elementum.'

Question.delete_all
Answer.delete_all
5.times do |n|
  Question.create(title: "Вопрос #{n + 1} ", body: text)
end

3.times do
  Answer.create(body: text, question_id: 1)
end
