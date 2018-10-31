#Drink Class
class Drink
  def initialize(argName, argPrice, argStock)
    self.setting(argName, argPrice, argStock)
  end
  
  def setting(argName, argPrice, argStock)
    self.setName(argName)
    self.setPrice(argPrice)
    self.setStock(argStock)
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