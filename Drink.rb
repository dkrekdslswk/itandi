#Drink Class
class Drink
  @@containerType = ['CAN', 'PET', 'ETC']
    
  def initialize(argName, argPrice, argStock, argMaker, argShelfLife, argContainer)
    self.setting(argName, argPrice, argStock, argMaker, argShelfLife, argContainer)
  end
  
  def setting(argName, argPrice, argStock, argMaker, argShelfLife, argContainer)
    self.setName(argName)
    self.setPrice(argPrice)
    self.setStock(argStock)
    self.setMaker(argMaker)
    self.setShelfLife(argShelfLife)
    self.setContainer(argContainer)
  end
  
  def self.getContainerType
    @@containerType
  end

  def getName
    @name
  end
  
  def setName(argName)
    @name = argName.to_s
  end
  
  def getPrice
    @price
  end
  
  def setPrice(argPrice)
    @price = argPrice.to_i
  end
  
  def getStock
    @stock
  end
  
  def setStock(argStock)
    @stock = argStock.to_i
  end
  
  def updateStock(argCount)
    @stock += argCount
  end

  def setMaker(argMaker)
    @maker = argMaker
  end
  
  def getMaker
    @maker
  end

  def setShelfLife(argShelfLife)
    if argShelfLife.kind_of?(Time)
      checkShelfLife = argShelfLife
    elsif @shelfLife.nil?
      checkShelfLife = Time.new
    end
    @shelfLife = checkShelfLife
  end

  def getShelfLife
    @shelfLife
  end
  
  def getShelfLifeStrftime
    @shelfLife.strftime("%Y-%m-%d")
  end

  def setContainer(argContainer)
    if @@containerType.include? argContainer
      checkContainer = argContainer
    elsif @container.nil?
      checkContainer = @@containerType[0]
    end
    @container = checkContainer
  end
  
  def getContainer
    @container
  end
  
  def getBuyningState(argMoney)
    if @stock == 0
      '無い'
    elsif @price <= argMoney
      '可能'
    else
      '有る'
    end
  end
end