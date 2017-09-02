# Similar Text

> 计算文本的相似哈希, 比较文本的相似度 

## 相似哈希计算过程

#### 收集
* 获取语料库，获取文本
* 遍历语料库，检索每个单词在文本中出现的频数，得出每个单词的 TF-IDF 值记作'w'

#### 扩展
* 根据加密算法初始化 n位都是 0 的二进制扩展实数，记作'r'(如用 MD5 是 32*4 位二进制数)
* 加密 TF-IDF>0 的单词并得出对应的二进制数记作't'。遍历t,若 tn(t的第n位) 为0，则  rn+w。若为1,则 rn-w。

####收缩
* 根据上述步骤计算出 r 后, 若 rn位>0, 则将这为变为 1, 否则变为 0, 最终得出的 r 为该文本的相似哈希


## 运用场景
* 通过语料库得到某篇文本的“相似哈希”值
* 比较两个文本的相似度

## HOW TO USE: 
### First: Config the Builder

```ruby
require_relative '../lib/simhash'

# 参数说明: 
# encrypt_method: 加密方式(Such as 'MD5', 'SHA1'), 默认 SHA1
# corpus: 语料库(['word1','word2',...]), 默认本项目语料库 
builder = Simhash::Builder.new(encrypt_method: 'MD5', corpus: corpus)
```

## API LISTS

### 得到单个文本的 cooked_textrue 对象, 该对象存储对应文本的 title 和 simhash
```ruby
# 入参: 
# text: 为响应 title(存放标题) 和 content(存放内容) 方法的对象
cooked_textrue = builder.cooked_textrue(text)
# return  => #<struct Struct::CookedTexture title="your_text_tile", simhash="00101...simhash_value_length_by_encrypt_method">
```


### 得到单个文本的 simhash 值 
```ruby
# 入参: 同上 
simhash = builder.textrue_simhash(text)
# retrun => "00101...simhash_value_length_by_encrypt_method"
```

### 根据文本内容对比相似度 返回区间 0~1 的小数，越大则说明两个文本的内容越接近 

```ruby
# 入参: 需要比较的两篇文本对象 (响应 title 和 content 方法的对象)
similarity = builder.compare_similarity_by_texture(text1, text2)
# return => 0.97
# 可以设置阈值与该相似值，用来判断文本是否抄袭
```

### 根据相似哈希对比相似度 

```ruby
# 入参: 需要比较的两篇文本的 simhash, 该值可通过 builder.textrue_simhash(text) 得出
similarity = builder.compare_similarity_by_hash(hash1, hash2)
# return => 同上
```

