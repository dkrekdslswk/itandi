require "./Drink"

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
  def putMoney(argMoney)
    case argMoney
      when 10, 50, 100, 500, 1000
        @money += argMoney
    else
      refundMoney(argMoney)
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
  
  #drink update
  #TODO class drinkを直すとき確認してください。
  def drinkUpdateUI(argDrinkNumber)
    if argDrinkNumber >= @drinkList.length
      puts 'cannot find a drink number for drink list'
      return false
    end
    commend = ''
    changeValue = ''
    
    puts '======================='
    puts argDrinkNumber.to_s + '.' + @drinkList[argDrinkNumber].getName
    puts 'price : ' + @drinkList[argDrinkNumber].getPrice.to_s
    puts 'stock : ' + @drinkList[argDrinkNumber].getStock.to_s
    puts '======================='
    puts 'drinkUpdate'
    puts '(1)change name'
    puts '(2)change stock'
    puts '(3)change price'
    puts '(end)back main menu'
    puts '======================='
    while commend != 'end'
      print '> '
      commend = gets.chomp
      if commend != 'end'
        print   argDrinkNumber.to_s + '.' + @drinkList[argDrinkNumber].getName
        case commend
        when '1'
          puts
          print '<= change name? : '
        when '2'
          puts  ', stock : ' + @drinkList[argDrinkNumber].getStock.to_s
          print '<= change stock? : '
        when '3'
          puts  ', price : ' + @drinkList[argDrinkNumber].getPrice.to_s
          print '<= change price? : '
        else
          next 
        end
        changeValue = gets.chomp

        print '.'
        case commend
        when '2', '3'
          if not changeValue.integer?
            puts 'is not integer'
            next
          end
        end
        
        print '.'
        case commend
        when ''
          when '1'
            @drinkList[argDrinkNumber].setName(changeValue)
            puts "new name : " + @drinkList[argDrinkNumber].getName
          when '2'
            @drinkList[argDrinkNumber].setStock(changeValue)
            puts "new stock : " + @drinkList[argDrinkNumber].getStock.to_s
          when '3'
            @drinkList[argDrinkNumber].setPrice(changeValue)
            puts "new price : " + @drinkList[argDrinkNumber].getPrice.to_s
        end
        puts 'change clear'  
      end
    end
    
    puts 'back main menu'
  end
  
  #new drink insert ui
  def drinkInsertUI
    tempName = ''
    tempStock = ''
    tempPrice = ''
    commend = ''
    
    while (commend != 'y') and (commend != 'n')
      print 'name : '
      tempName = gets.chomp
      print 'price : '
      tempPrice = gets.chomp
      print 'stock : '
      tempStock = gets.chomp
      
      while (commend != 'y') and (commend != 'r') and (commend != 'n')
        puts tempName + ', price : ' + tempPrice + ', stock : ' + tempStock
        puts 'save : y, rectify : r, cancel : n'
        print '> '
        commend = gets.chomp
      end
    end
    
    if commend == 'y'
      self.drinkInsert(tempName, tempPrice, tempStock)
      puts 'save clear'
    end
  end
  
  # new drink in drink list
  def drinkInsert(argName, argPrice, argStock)
    @drinkList.push(Drink.new(argName, argPrice, argStock))
  end
  
  #drink delete
  def drinkDelete(drinkNumber)
    if drinkNumber >= @drinkList.length
      return false
    else
      @drinkList.delete_at(drinkNumber)
    end
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