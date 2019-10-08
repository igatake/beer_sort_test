require 'levenshtein'

module Levenshtein
  def self.similarity(str1, str2)
    1 - normalized_distance(str1, str2)
  end

# p Levenshtein.similarity("アサヒ スーパードライ エクストラコールド　生ビール") #=> 0.6666666666666667
# p Levenshtein.similarity("ザ・プレミアム・モルツ") #=> 0.6
# p Levenshtein.similarity("サッポロ黒ラベル　ジョッキ") #=> 0.0

  def self.check_ebisu(drink)
    if drink.include?("ヱビス") || drink.include?("エビス")
      p "エビスビール"
    elsif drink.include?('生ビール')
      p "生ビール"
    else
      p "その他"
    end
  end

  def self.beer_comparer(beer_name)
      kirin = Levenshtein.similarity(beer_name, "キリン一番搾り")
      asahi = Levenshtein.similarity(beer_name, "アサヒスーパードライ")
      puremoru = Levenshtein.similarity(beer_name, "ザ・プレミアム・モルツ")
      sapporo = Levenshtein.similarity(beer_name, "サッポロ黒ラベル")
      ebisu =  Levenshtein.similarity(beer_name, "ヱビスビール")
      beer_array = [kirin, asahi, puremoru, sapporo, ebisu]
      beer_array.sort!.reverse!
      p beer_array[0]
      if beer_array[0] <= 0.15
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
