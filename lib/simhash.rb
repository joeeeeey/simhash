require_relative 'helpers/utils'
require_relative 'materials/corpus'

module Simhash
  module Utils
    def encryption(method, str)
      send(method, str)
    end

    # 收缩 生成二进制相似哈希
    # 将数组中大于 0 的数变为 1
    #        小于 0 的数变为 0  
    def shrink(simhash_array)
      simhash_binary_string = ''
      simhash_array.each do |e|
        if e > 0
          simhash_binary_string += '1'
        else 
          simhash_binary_string += '0'  
        end
      end
      return simhash_binary_string
    end
  end

  module ApiList
    # 得到单个文本的 cooked_textrue 对象
    def cooked_textrue(texture)
      return cook_textrue(texture)
    end

    # 得到单个文本的 simhash 值
    def textrue_simhash(texture)
      return cook_textrue(texture).simhash
    end
   
    # def textrue_similarity(texture1, texture2)
    #   return similarity(textrue_simhash(texture1), textrue_simhash(texture2))
    # end

    # 根据文本对比相似度
    def compare_similarity_by_texture(texture1, texture2)
      compare_similarity_by_hash(textrue_simhash(texture1), textrue_simhash(texture2))
    end

    # 根据相似哈希对比相似度
    def compare_similarity_by_hash(h1, h2)
      a1 = h1.split('')
      a2 = h2.split('')
      sim_value = 0
      a1.each_with_index do |e, index|
        sim_value += 1 if e == a2[index]
      end
      return sim_value / a1.size.to_f
    end
  end

  class Builder
    include Classify::Utils
    include Simhash::Utils
    include Simhash::ApiList
    
    attr_accessor  :encrypt_method, :binary_size, :corpus 

    DEFAULT_CONFIG = {encrypt_method: "SHA1", binary_size: 40*4}

    def initialize(options={})
      p "initialize BuilderConfig"
      encrypt_method = options[:encrypt_method]
      # validate encrypt_method
      if encrypt_method
        # 选择生成信息指纹的加密算法
        # 可以是 SHA1 MD5. TODO 增加新的
        # 不同的加密算法产生的二进制位数不同，在此做出对应
        options[:binary_size] = case encrypt_method
                               when "SHA1" then 40*4
                               when "MD5"  then 32*4
                               else 
                                 raise ArgumentError.new "This Method not allowed: #{encrypt_method.to_s}(暂不支持该加密算法) "
                               end
      else 
        # 防止 binary_size 不对应加密算法错误传入
        options[:binary_size] = nil  
      end

      corpus = options[:corpus]

      # validate corpus
      raise ArgumentError.new("Corpus should be an array (语料库必须是数组)") if corpus && !corpus.is_a?(Array)

      [:encrypt_method, :binary_size, :corpus].each do |attribute|
         # 只在实例 BuilderConfig 对象并且使用默认语料库情况才获取本地语料
         if attribute == :corpus
           instance_variable_set("@corpus", options[attribute]||= Material::Corpus.all)
         end
   
         instance_variable_set("@#{attribute.to_s}", options[attribute]||= DEFAULT_CONFIG[attribute])
      end
    end

    # 类名为 CookedTexture 的构造体
    CookedTexture = Struct.new("CookedTexture", :title, :simhash)

    # 入参: 词库 array， 文章 array
    # 词库可以选取自己的词库，或者用默认的词库 
    # 词库数据格式 ['word1', 'word2', ..]
    # 文本 对象
    # 文本对象至少响应 title 和 content 方法
    def cook_textrue(texture, *args)
      weight_with_sha1_array = []
     
      simhash_array = Array.new(binary_size, 0)

      corpus.each_with_index do |e, index|
        # 单词出现数量
        dw = count_em(texture.content, e)
        next if dw == 0
        #  计算单词的 TF-IDF
        tf_idf = Math.log2(corpus.size / dw).round(3) 

        # 用字符串 0 补齐位数
        binary = add_zero_prefix(encryption(encrypt_method, e).to_i(16).to_s(2), binary_size)

        # [1,0,0,1,1,1,1,0,0...]
        binary.split('').map(&:to_i).each_with_index do |e, index|
          case e
          when 1 then simhash_array[index] += tf_idf
          when 0 then simhash_array[index] -= tf_idf  
          end
        end
      end

      return CookedTexture.new(texture.title, shrink(simhash_array))
    end

  end
end




