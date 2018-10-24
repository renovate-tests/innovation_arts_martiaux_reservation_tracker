class CashPayment < ApplicationRecord
  belongs_to :user

  def self.to_csv(options = {})
    desired_columns = ["id", "name", "email", "telephone", "due_date", "paid"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |cash_payment|
        csv << cash_payment.attributes.values_at(*desired_columns)
      end
    end
  end


  def self.search(search, page)
    self.joins(:user).where("lower(users.name) LIKE :query", query: "%#{search.downcase}%").paginate(:page => page, :per_page => 10).order('users.name ASC')
  end

end
