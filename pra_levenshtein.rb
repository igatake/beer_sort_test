require 'levenshtein'

module Levenshtein
  def self.similarity(str1, str2)
    1 - normalized_distance(str1, str2)
  end

  def self.check_ebisu(drink)
    #ヱビスは'ビ'が入っているためポイントが高くなりガチなので丁寧に
    if drink.include?("ヱビス") || drink.include?("エビス")
      p "エビスビール"
    elsif drink.include?('生ビール')
      p "生ビール"
    else
      p "その他"
    end
  end

  def self.beer_comparer(beer_name
    それぞれの類似ポイントを算出
    kirin = Levenshtein.similarity(beer_name, "キリン一番搾り")
    asahi = Levenshtein.similarity(beer_name, "アサヒスーパードライ")
    puremoru = Levenshtein.similarity(beer_name, "ザ・プレミアム・モルツ")
    sapporo = Levenshtein.similarity(beer_name, "サッポロ黒ラベル")
    ebisu =  Levenshtein.similarity(beer_name, "ヱビスビール")
    beer_array = [kirin, asahi, puremoru, sapporo, ebisu]
    #点数順に並べる
    beer_array.sort!.reverse!
    p beer_array[0]
    #ポイントが一番高いものを選別
    if beer_array[0] <= 0.15 #ここのポイントは微調整が必要
      p "その他"
    elsif beer_array[0] == kirin
      p "キリン"
    elsif beer_array[0] == asahi
      p "アサヒスーパードライ"
    elsif beer_array[0] == puremoru
      p "ザ・プレミアム・モルツ"
    elsif beer_array[0] == sapporo
      p "サッポロ黒ラベル"
    else
      Levenshtein.check_ebisu(beer_name)
    end
  end
end
