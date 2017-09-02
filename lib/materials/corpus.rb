# 语料库
module Material
  class Corpus
    class << self
      def all
        # words_arr = %w[ 洞朗 地区 撤军 印方 挑起 越界 事件 历经 两个多月 得到 解决 标志
        #                 印方 停止 违法 行为 回到 遵守 国际法 正常轨道 明智之举
        #                 事实 不容狡辩 位于 边界线 中方 一侧 长期以来 存在 争议
        #                 印军 非法 越界 严重 侵犯 中国 领土主权 国际法 基本原则 国际关系
        #                 基本准则 践踏 中国 政府 重视 发展 同 印度 睦邻 友好 关系
        #                 希望 印方 切实 遵守 历史界约 国际法 基本原则 中方 一道
        #                 互相尊重 领土主权 基础上 维护 边境地区 和平 安宁 促进 两国关系 健康 发展
        #                 腾讯 体育 北京 时间 赛季 英超 一场 重头戏 利物浦 主场 大胜 阿森纳 
        #                 菲尔米诺 萨拉赫 均 传射 建功 马内 连续 破门 斯图里奇 替补 进球
        #                 分钟 阿森纳 角球 传中 解围 贝莱林 停球 太大 萨拉赫 高速 上抢 单刀 高速 杀入 禁区
        #                 埃及梅西 面对 切赫 冷静 低射 左下角 得手 霍尔丁 解围 失误
        #                 马内 禁区 右侧 攻门 切赫 扑了一下 球 往 门内 滚 贝莱林门 线上 做出 关键 解围
        #                 初音未来 正式 大家 见面 现在 初音 十 周年 公主殿下 终于 十岁 撒花 COS 选景 太棒 COSER
        #                 表现力 五角大楼 美军 部队 叙利亚 北部 土耳其 支持 反政府 武装控制 地区 屡遭 枪击 开火 还击
        #                 国防官员 告诉 美国之音 领导 盟军 部队 不明团体 袭击 驻扎 巴格达 军方 发言人
        #                 袭击 事件 人员伤亡 设备损伤 国防部 发言人 相关方面 接触 解决 威胁
        #                 继续 支持 曼比季 军事 委员会 控制 地区 巡逻 面对 任何 进行 自卫
        #                 负责 监督 阻止 敌对 事件 发生 确保 各方 集中 精力 打击 共同 敌人
        #                 地区 世界 安全 构成 威胁 伊斯兰国 组织 敦促 各方 精力 集中 打击 
        #                 支持 武装力量 反对 总统 阿萨德 民主 力量 库尔德战士 冲突
        #                 有关 官员 没有 证据 显示 袭击

        #               ].uniq!  
        words_arr = ["洞朗", "地区", "撤军", "印方", "挑起", "越界", "事件", "历经", 
                      "两个多月", "得到", "解决", "标志", "停止", "违法", "行为", 
                      "回到", "遵守", "国际法", "正常轨道", "明智之举", 
                      "事实", "不容狡辩", "位于", "边界线", "中方", "一侧", 
                      "长期以来", "存在", "争议", "印军", "非法", "严重", 
                      "侵犯", "中国", "领土主权", "基本原则", "国际关系", 
                      "基本准则", "践踏", "政府", "重视", "发展", "同", "印度", 
                      "睦邻", "友好", "关系", "希望", "切实", "历史界约", "一道",
                       "互相尊重", "基础上", "维护", "边境地区", "和平", "安宁", "促进", 
                       "两国关系", "健康", "腾讯", "体育", "北京", "时间", "赛季", "英超", 
                       "一场", "重头戏", "利物浦", "主场", "大胜", "阿森纳", "菲尔米诺", "萨拉赫", 
                       "均", "传射", "建功", "马内", "连续", "破门", "斯图里奇", "替补", "进球", 
                       "分钟", "角球", "传中", "解围", "贝莱林", "停球", "太大", "高速", "上抢", 
                       "单刀", "杀入", "禁区", "埃及梅西", "面对", "切赫", "冷静", "低射", "左下角", 
                       "得手", "霍尔丁", "失误", "右侧", "攻门", "扑了一下", "球", "往", "门内", "滚", 
                       "贝莱林门", "线上", "做出", "关键", "初音未来", "正式", "大家", "见面", "现在", 
                       "初音", "十", "周年", "公主殿下", "终于", "十岁", "撒花", "COS", "选景", "太棒", 
                       "COSER", "表现力", "五角大楼", "美军", "部队", "叙利亚", "北部", "土耳其", "支持",
                        "反政府", "武装控制", "屡遭", "枪击", "开火", "还击", "国防官员", "告诉", "美国之音", 
                        "领导", "盟军", "不明团体", "袭击", "驻扎", "巴格达", "军方", "发言人", "人员伤亡", 
                        "设备损伤", "国防部", "相关方面", "接触", "威胁", "继续", "曼比季", "军事", "委员会", 
                        "控制", "巡逻", "任何", "进行", "自卫", "负责", "监督", "阻止", "敌对", "发生", "确保", 
                        "各方", "集中", "精力", "打击", "共同", "敌人", "世界", "安全", "构成", "伊斯兰国", 
                        "组织", "敦促", "武装力量", "反对", "总统", "阿萨德", "民主", "力量", "库尔德战士", 
                        "冲突", "有关", "官员", "没有", "证据", "显示"].uniq
      end
      # def hash_table
      #   # 准备数据格式为 hash 的词汇表， hash 中的元素 key 从 1 自增
      #   i = 1
      #   words_hash_table = {}
      #   total_words.each do |e|
      #     words_hash_table.merge!({i => e})
      #     i+=1
      #   end
      # end
    end
  end
end