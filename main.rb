#StringがIntegerかを確認するための設定
class String
  def integer?
    Integer(self) != nil rescue false
  end
end

#自販機Class
class Dihanki

  #変数を設定
  def initialize
    #お客様が投入したお金
    @money = 0
    #自販機の売上金額
    @sales = 0
    #ドリンクの情報[ドリンクの番号][0：名、1：値段、2：在庫、[3：状態]]
    @drink_list = [['コーラ', 120, 5,],
                    ['レッドブル', 200, 5,],
                    ['水', 100, 5,]]
  end

  #return 現在のお客様が投入したお金
  def viewMoney()
    return @money
  end

  #お金の投入
  #10,50,100,500,1000以外のが投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
  def putMoney(arg_money)
    case arg_money
      when 10, 50, 100, 500, 1000
        @money += arg_money
    else
      refundMoney(arg_money)
    end
  end

  #自販機のジュースの情報を出す。
  def viewDrinkList()
    @drink_list.each() do |drink|
      drink[3] = ''
      if drink[2] == 0
        drink[3] = '無い'
      elsif drink[1] <= self.viewMoney()
        drink[3] = '可能'
      else
        drink[3] = '有る'
      end
    end
    return @drink_list
  end

  #購入できるドリンクリストのドリンク番号を出す。
  def viewInhabitableDrinkList()
    drink_list = self.viewDrinkList()
    inhabitable_drink_list = []
    save_p = 0
    drink_number = 0
    drink_list.each() do |drink|
      if drink[3] == '可能'
        inhabitable_drink_list[save_p] = drink_number
        save_p += 1
      end
      drink_number += 1
    end
    return inhabitable_drink_list
  end

  #自販機の売上金額を出す。
  def viewSales()
    return @sales
  end

  #ドリンクを買う。
  #購入した場合、残ったお金を全部払い戻しする。
  #お金が足りない場合、何も行いません。
  def buyingDrink(drink_number)
    if @drink_list.length > drink_number
      drink = @drink_list[drink_number]

      if drink[1] <= @money and drink[2] > 0
        drink[2] -= 1
        @money -= drink[1]
        @sales += drink[1]
        #今はputsですが、ここに出る作業が入ります。
        puts '= buy drink : ' + drink[0]
      end
    end
    #お金が足りない場合、何も行いません。
  end

  #残ったお金を全部払い戻しする。
  def refundAllMoney()
    refundMoney(@money)
    @money = 0
  end

  #お金を払い戻し作業は全部そこでする。
  # TODO: 直接呼ぶのは思えません。
  private def refundMoney(refund_money)
    #今はputsですが、ここに出る作業が入ります。
    puts '= ref money : ' + refund_money.to_s
  end
end

#自販機のObject
dihanki = Dihanki.new()

#ユーザーの命令を受け入れる。
command = ''

while command != 'end'
  puts '===================='
  puts '[drinkNumber]'
  drink_number = 0
  inhabitable_drink_list = dihanki.viewInhabitableDrinkList()
  inhabitable_count = 0
  dihanki.viewDrinkList().each() do |drink|
    if drink_number == inhabitable_drink_list[inhabitable_count]
      print '*'
      inhabitable_count += 1
    else
      print ' '
    end
    puts '[' + drink_number.to_s + '] ' + drink[3] + ' - ' + drink[0] + '(' + drink[1].to_s + '￥) stock : ' + drink[2].to_s
    drink_number += 1
  end
  puts '======  data  ======'
  puts 'dihanki sales = ' + dihanki.viewSales().to_s
  puts 'user money  = ' + dihanki.viewMoney().to_s
  puts '====  commands  ===='
  puts '[number]         : putMoney       (例:10,50,100,500,1000)'
  puts 'get[drinkNumber] : drink buying   (例:get0)'
  puts 'ref              : refund all money'
  puts 'end              : end'
  puts '===================='
  print 'command : '
  command = gets.chomp

  puts
  puts '===================='
  if command == 'ref'
    dihanki.refundAllMoney
  elsif command == 'end'
    puts 'Bye~'
  elsif command[0, 3] == 'get'
    if  command[3, command.length].integer?
      dihanki.buyingDrink(command[3, command.length].to_i)
    end
  elsif command.integer?
    dihanki.putMoney(command.to_i)
  else
    puts 'bad command'
  end

end
