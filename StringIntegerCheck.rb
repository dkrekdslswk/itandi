#StringがIntegerかを確認するための設定
class String
  def integer?
    Integer(self) != nil rescue false
  end
end