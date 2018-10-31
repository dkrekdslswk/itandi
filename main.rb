#StringがIntegerかを確認するための設定
class String
  def integer?
    Integer(self) != nil rescue false
  end
end

#Drink Class
class Drink
  def initialize(argName, argPrice, argStock)
    @name = argName
    @price = argPrice
    @stock = argStock
  end

  def getName
    @name
  end
  
  def getPrice
    @price
  end
  
  def getStock
    @stock
  end
  
  def updateStock(argCount)
    @stock += argCount
  end
  
  def getBuyningState(argMoney)
    if @stock == 0
      return '無い'
    elsif @price <= argMoney
      return '可能'
    else
      return '有る'
    end
  end
end

#自販機Class
class Jihanki

  #変数を設定
  def initialize
    #お客様が投入したお金
    @money = 0
    #自販機の売上金額
    @sales = 0
    #ドリンクの情報[ドリンクの番号]
    @drinkList = [Drink.new('コーラ', 120, 5),
                  Drink.new('レッドブル', 200, 5),
                  Drink.new('水', 100, 5)]
  end

  #return 現在のお客様が投入したお金
  def getMoney()
    @money
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
  def getDrinkList()
    @drinkList
  end

  #購入できるドリンクリストのドリンク番号を出す。
  def getInhabitableDrinkList()
    drinkList = self.getDrinkList()
    inhabitableDrinkList = []
    saveP = 0
    drinkNumber = 0
    drinkList.each() do |drink|
      if drink.getBuyningState(@money) == '可能'
        inhabitableDrinkList[saveP] = drinkNumber
        saveP += 1
      end
        drinkNumber += 1
    end

    inhabitableDrinkList
  end

  #自販機の売上金額を出す。
  def getSales()
    @sales
  end

  #ドリンクを買う。
  #購入した場合、残ったお金を全部払い戻しする。
  #お金が足りない場合、何も行いません。
  def buyingDrink(drinkNumber)
    if @drinkList.length > drinkNumber
      drink = @drinkList[drinkNumber]
      
      if drink.getBuyningState(@money) == '可能'
        drink.updateStock(-1)
        @money -= drink.getPrice
        @sales += drink.getPrice
        #今はputsですが、ここに出る作業が入ります。
        puts '= buy drink : ' + drink.getName
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
  private def refundMoney(refundMoney)
    #今はputsですが、ここに出る作業が入ります。
    puts '= ref money : ' + refundMoney.to_s
  end
end

#自販機のObject
jihanki = Jihanki.new()

#ユーザーの命令を受け入れる。
command = ''

while command != 'end'
  puts '===================='
  puts '[drinkNumber]'
  drinkNumber = 0
  inhabitableDrinkList = jihanki.getInhabitableDrinkList()
  inhabitableCount = 0
  jihanki.getDrinkList.each() do |drink|
    if inhabitableCount < inhabitableDrinkList.length
      if drinkNumber == inhabitableDrinkList[inhabitableCount]
        print '*'
        inhabitableCount += 1
      else
        print ' '
      end
    end
    puts '[' + drinkNumber.to_s + '] ' + drink.getBuyningState(jihanki.getMoney()) + ' - ' + drink.getName + '(' + drink.getPrice.to_s + '￥) stock : ' + drink.getStock.to_s
    drinkNumber += 1
  end
  puts '======  data  ======'
  puts 'jihanki sales = ' + jihanki.getSales.to_s
  puts 'user money  = ' + jihanki.getMoney.to_s
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
    jihanki.refundAllMoney
  elsif command == 'end'
    puts 'Bye~'
  elsif command[0, 3] == 'get'
    if  command[3, command.length].integer?
      jihanki.buyingDrink(command[3, command.length].to_i)
    end
  elsif command.integer?
    jihanki.putMoney(command.to_i)
  else 
    puts 'bad command'
  end

end
