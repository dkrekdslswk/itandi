require "./Drink"
require "./StringIntegerCheck"

#自販機Class
class Jihanki

  #変数を設定
  def initialize
    #お客様が投入したお金
    @money = 0
    #自販機の売上金額
    @sales = 0
    #ドリンクの情報[ドリンクの番号]
    @drinkList = [Drink.new('コーラ',     120, 5, 'coca cola',  Time.new(2018, 12, 15), 'PET'),
                  Drink.new('レッドブル',  200, 5, 'オーストリア',  Time.new(2018, 12, 25), 'CAN'),
                  Drink.new('水',        100, 5, 'トップページ',  Time.new(2019, 1, 15), 'PET')]
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
  def drinkUpdateCall(argDrinkNumber)
    if argDrinkNumber >= @drinkList.length
      puts 'cannot find a drink number for drink list'
      return false
    end
    
    self.drinkUpdateUI(@drinkList[argDrinkNumber], argDrinkNumber)
  end
  
  def drinkUpdateUI(argDrink, argNumber)
    commend = ''
    changeValue = ''
    
    puts '======================='
    puts argNumber.to_s + '.' + argDrink.getName
    puts 'stock       : ' + argDrink.getStock.to_s
    puts 'price       : ' + argDrink.getPrice.to_s
    puts 'maker       : ' + argDrink.getMaker
    puts 'shelf life  : ' + argDrink.getShelfLifeStrftime
    puts 'container   : ' + argDrink.getContainer
    puts '======================='
    puts 'drinkUpdate'
    puts '(1)change name'
    puts '(2)change stock'
    puts '(3)change price'
    puts '(4)change maker'
    puts '(5)change shelf life'
    puts '(6)change container'
    puts '(end)back main menu'
    puts '======================='
    while commend != 'end'
      print '> '
      commend = gets.chomp
      if commend != 'end'
        print   argNumber.to_s + '.' + argDrink.getName
        case commend
          when '1'
            puts
            print '<= change name? : '
          when '2'
            puts  ', stock : ' + argDrink.getStock.to_s
            print '<= change stock? : '
          when '3'
            puts  ', price : ' + argDrink.getPrice.to_s
            print '<= change price? : '
          when '4'
            puts  ', maker : ' + argDrink.getMaker
            print '<= change maker? : '
          when '5'
            puts ', shelf life : ' + argDrink.getShelfLifeStrftime
            puts 'year-month-day(ex : 2000-12-12, 2000-1-1)'
            print '<= change shelf life? : '
          when '6'
            puts  ', container : ' + argDrink.getContainer
            print Drink.getContainerType
            puts
            print '<= change container? : '
        else
          next 
        end
        changeValue = gets.chomp

        # value check
        print '.'
        case commend
        when '2', '3'
          if not changeValue.integer?
            puts 'is not integer'
            next
          end
        when '5'
          shelfLifeTimeSplit = changeValue.split('-')
          checkTime = Time.new()
          if shelfLifeTimeSplit.length != 3
            puts 'is not date data type'
            next
          elsif not shelfLifeTimeSplit[0].integer? and shelfLifeTimeSplit[1].integer? and shelfLifeTimeSplit[2].integer?
            puts 'date data type is not integer'
            next
          end
          changeTime = Time.new(shelfLifeTimeSplit[0].to_i, shelfLifeTimeSplit[1].to_i, shelfLifeTimeSplit[2].to_i)
        when '6'
          if not Drink.getContainerType.include? changeValue
            puts 'is not find container type'
            next
          end
        end
        
        # change save
        print '.'
        case commend
        when ''
          when '1'
            argDrink.setName(changeValue)
            puts "new name : " + argDrink.getName
          when '2'
            argDrink.setStock(changeValue)
            puts "new stock : " + argDrink.getStock.to_s
          when '3'
            argDrink.setPrice(changeValue)
            puts "new price : " + argDrink.getPrice.to_s
          when '4'
            argDrink.setMaker(changeValue)
            puts "new maker : " + argDrink.getMaker
          when '5'
            argDrink.setShelfLife(changeTime)
            puts "new shelf life : " + argDrink.getShelfLifeStrftime
          when '6'
            argDrink.setContainer(changeValue)
            puts "new container : " + argDrink.getContainer
        end
        puts 'change clear'  
      end
    end
    
    puts 'back main menu'
    return 1
  end
  
  #new drink insert ui
  def drinkInsertUI
    tempDrink = Drink.new('defaultName', 100, 5, 'defaultMaker', Time.new, 'CAN')
    commend = ''
    
    while (commend != 'y') and (commend != 'n')
      self.drinkUpdateUI(tempDrink, 'insert')
      
      while (commend != 'y') and (commend != 'r') and (commend != 'n')
        puts tempDrink.getName + ', price : ' + tempDrink.getPrice.to_s + ', stock : ' + tempDrink.getStock.to_s
        puts 'maker : ' + tempDrink.getMaker + ', shelf life : ' + tempDrink.getShelfLifeStrftime + ', container : ' + tempDrink.getContainer
        puts 'save : y, rectify : r, cancel : n'
        print '> '
        commend = gets.chomp
      end
    end
    
    if commend == 'y'
      @drinkList.push(tempDrink)
      puts 'save clear'
    end
  end
  
  #drink delete
  def drinkDelete(drinkNumber)
    if drinkNumber >= @drinkList.length
      false
    else
      @drinkList.delete_at(drinkNumber)
    end
  end
  
  #自販機の売上金額を出す。
  def getSales()
    return @sales
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