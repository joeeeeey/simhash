# 示例

require_relative '../lib/materials/article'

articles = Material::Article.obj_data

require_relative '../lib/simhash'

builder =  Simhash::Builder.new(encrypt_method: 'MD5', corpus: (0...30000).to_a.map(&:to_s))

p builder.cooked_textrue(articles[6])

articles.each do |article|
  simhash = builder.textrue_simhash(article)
  p simhash
end


p builder.compare_similarity_by_texture(articles[7], articles[6])
p builder.compare_similarity_by_texture(articles[1], articles[2])
p builder.compare_similarity_by_texture(articles[2], articles[3])
# # => 0.9











