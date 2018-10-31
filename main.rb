require './Jihanki'

#StringがIntegerかを確認するための設定
class String
  def integer?
    Integer(self) != nil rescue false
  end
end

#自販機のObjectSS
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
  puts '[number]            : putMoney       (例:10,50,100,500,1000)'
  puts 'get[drinkNumber]    : drink buying   (例:get0)'
  puts 'ref                 : refund all money'
  puts 'update[drinkNumber] : drink update'
  puts 'insert              : new drink insert'
  puts 'delete[drinkNumber] : drink delete'
  puts 'end                 : end'
  puts '===================='
  print '> '
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
  elsif command[0, 6] == 'update'
    if  command[6, command.length].integer?
      jihanki.drinkUpdateUI(command[6, command.length].to_i)
    end
  elsif command == 'insert'
    jihanki.drinkInsertUI()
  elsif command[0, 6] == 'delete'
    if  command[6, command.length].integer?
      jihanki.drinkDelete(command[6, command.length].to_i)
    end
  elsif command.integer?
    jihanki.putMoney(command.to_i)
  else 
    puts 'bad command'
  end

end
