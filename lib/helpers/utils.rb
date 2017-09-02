require 'digest'
module Classify
  module Utils
    def count_em(string, substring)
      string.scan(/(?=#{substring})/).count
    end

    def MD5(str)
      Digest::MD5.hexdigest str
    end

    def SHA1(str)
      Digest::SHA1.hexdigest str
    end

    # 入参: "Astring", 10
    # 说明: 将传入的字符串用 '0' 作为前缀补全到位数为 length
    #      lenght <= 当前位数时则返回原字符串
    # 例如: add_zero_prefix('123',6) == "000123"
    #      add_zero_prefix('123', 3) == "123"
    def add_zero_prefix(str, length)
      str = str.to_s
      (length - str.size).times { str.insert(0, '0') }
      str
    end 
  end
end

