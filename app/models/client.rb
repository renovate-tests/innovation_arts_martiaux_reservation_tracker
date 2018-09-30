class Client < ApplicationRecord
  require 'csv'

  validates(:name, presence: true, uniqueness: true)
  validates(:telephone, presence: true, uniqueness: true)
  validates(:email, presence: true, uniqueness: true)


  has_many :student, :dependent => :destroy
  has_many :reservation, through: :student

  def self.search(search, page)
    self.where("lower(name) LIKE :query", query: "%#{search.downcase}%")
        .paginate(:page => page, :per_page => 10).order('active desc, name ASC')
  end


  def self.to_csv(options = {})
    desired_columns = ["id", "name", "telephone", "email", "active"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |clients|
        csv << clients.attributes.values_at(*desired_columns)
      end
    end
  end


end
