module UsersHelper
  # age,genderに入力漏れがあった場合にエラーを発生させる
  def processing_for_validates
    if self.age == "default_age"
      self.age = ''
    end

    if self.gender == 'default_gender'
      self.gender = ''
    end
  end
end
