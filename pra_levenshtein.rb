require 'levenshtein'
require 'csv'

module Levenshtein
  def self.similarity(str1, str2)
    1 - normalized_distance(str1, str2)
  end

  def self.check_ebisu(drink)
    #ヱビスは'ビ'が入っているためポイントが高くなりガチなので丁寧に
    if drink.include?('ヱビス') || drink.include?('エビス')
      p 'エビスビール'
    elsif drink.include?('生ビール')
      Levenshtein.finer_check(drink)
    else
      p 'その他'
    end
  end

  def self.finer_check(drink)
    if drink.include?('ヱビス') || drink.include?('エビス')
      p 'エビスビール'
    elsif drink.include?('アサヒ') || drink.include?('スーパードライ')
      p 'アサヒスーパードライ'
    elsif drink.include?('モルツ')
      p 'ザ・プレミアム・モルツ'
    elsif drink.include?('サッポロ') || drink.include?('黒ラベル')
      p 'サッポロ黒ラベル'
    elsif drink.include?('キリン') || drink.include?('一番搾り')
      p 'キリン一番搾り'
    else
      p '生ビール'
    end
  end

  def self.beer_comparer(beer_name)
    #それぞれの類似ポイントを算出
    kirin = Levenshtein.similarity(beer_name, 'キリン一番搾り')
    asahi = Levenshtein.similarity(beer_name, 'アサヒスーパードライ')
    puremoru = Levenshtein.similarity(beer_name, 'ザ・プレミアム・モルツ')
    sapporo = Levenshtein.similarity(beer_name, 'サッポロ黒ラベル')
    ebisu =  Levenshtein.similarity(beer_name, 'ヱビスビール')
    beer_array = [kirin, asahi, puremoru, sapporo, ebisu]
    #点数順に並べる
    beer_array.sort!.reverse!
    p beer_array[0]
    #ポイントが一番高いものを選別
    if beer_name.include?('瓶ビール') #瓶ビールはとりあえず種類は選ばず抽出
      p '瓶ビール'
    elsif beer_array[0] <= 0.15 #ここのポイントは微調整が必要
      if beer_name.include?('生ビール')
        Levenshtein.finer_check(beer_name)
      else
        p 'その他'
      end
    elsif beer_array[0] == kirin
      p 'キリン'
    elsif beer_array[0] == asahi
      p 'アサヒスーパードライ'
    elsif beer_array[0] == puremoru
      p 'ザ・プレミアム・モルツ'
    elsif beer_array[0] == sapporo
      p 'サッポロ黒ラベル'
    else
      Levenshtein.check_ebisu(beer_name)
    end
  end
end

file_name = 'result_ikebukuro_20191008-161635.csv'

header = %w[drink price name url]
CSV.foreach("./#{file_name}", headers: true) do |row|
  p drink_name = row[0]
  Levenshtein.beer_comparer(drink_name)
end
