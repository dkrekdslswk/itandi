#Drink Class
class Drink
  @containerTypes = ['CAN', 'PET', 'ETC']
    
  def initialize(argName, argPrice, argStock, argMaker, argShelfLife, argContainer)
    self.setting(argName, argPrice, argStock, argMaker, argShelfLife, argContainer)
  end
  
  def setting(argName, argPrice, argStock, argMaker, argShelfLife, argContainer)
    self.name = argName.to_s
    self.price = argPrice.to_i
    self.stock = argStock.to_i
    self.maker = argMaker.to_s
    self.setShelfLife(argShelfLife)
    self.setContainer(argContainer)
  end
  
  class << self
    attr_reader :containerTypes
  end

  attr_accessor :name
  attr_accessor :price
  attr_accessor :stock
  attr_accessor :maker
  attr_reader   :shelfLife
  attr_reader   :container
  
  def updateStock(argCount)
    @stock += argCount
  end

  def setShelfLife(argShelfLife)
    if argShelfLife.kind_of?(Time)
      checkShelfLife = argShelfLife
    elsif self.shelfLife.nil?
      checkShelfLife = Time.new
    end
    @shelfLife = checkShelfLife
  end
  
  def getShelfLifeStrftime
    self.shelfLife.strftime("%Y-%m-%d")
  end

  def setContainer(argContainer)
    if Drink.containerTypes.include? argContainer
      checkContainer = argContainer
    elsif self.container.nil?
      checkContainer = Drink.containerTypes[0]
    end
    @container = checkContainer
  end
  
  def getBuyningState(argMoney)
    if self.stock == 0
      '無い'
    elsif self.price <= argMoney
      '可能'
    else
      '有る'
    end
  end
end