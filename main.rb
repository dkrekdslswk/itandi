require "./Jihanki"
require "./StringIntegerCheck"

#自販機のObject
jihanki = Jihanki.new()

print Drink.containerTypes

#ユーザーの命令を受け入れる。
command = ''

while command != 'end'
  puts '===================='
  puts '[drinkNumber]'
  drinkNumber = 0
  inhabitableDrinkList = jihanki.getInhabitableDrinkList()
  inhabitableCount = 0
  jihanki.drinkList.each() do |drink|
    if inhabitableCount < inhabitableDrinkList.length
      if drinkNumber == inhabitableDrinkList[inhabitableCount]
        print '*'
        inhabitableCount += 1
      else
        print ' '
      end
    end
    print '[' + drinkNumber.to_s + '] ' + drink.getBuyningState(jihanki.money)
    print ' - ' + drink.name + '(' + drink.price.to_s + '￥)'
    print 'stock : ' + drink.stock.to_s
    print ', maker : ' + drink.maker
    print ', ' + drink.container
    puts ', ' + drink.getShelfLifeStrftime
    drinkNumber += 1
  end
  puts '======  data  ======'
  puts 'jihanki sales = ' + jihanki.sales.to_s
  puts 'user money  = ' + jihanki.money.to_s
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
  case command
  when 'ref'
    jihanki.refundAllMoney
  when 'end'
    puts 'Bye~'
  when /^get[0-9]{1,}$/
    jihanki.buyingDrink(command[3, command.length].to_i)
  when 'insert'
    jihanki.drinkInsertUI()
  when /^update[0-9]{1,}$/
    jihanki.drinkUpdateCall(command[6, command.length].to_i)
  when /^delete[0-9]{1,}$/
    jihanki.drinkDelete(command[6, command.length].to_i)
  when /^[0-9]{1,}$/
    jihanki.putMoney(command.to_i)
  else
    puts 'bad command'
  end
end
