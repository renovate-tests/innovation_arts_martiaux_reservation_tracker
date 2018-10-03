class Student < ApplicationRecord
  validates(:name, presence: true, uniqueness: {scope: :user_id})
  has_many :graduation, foreign_key: 'student_id', :dependent => :destroy
  has_many :reservation, foreign_key: 'student_id', :dependent => :destroy

  def self.search(search, page)
    self.where("lower(name) LIKE :query", query: "%#{search.downcase}%").paginate(:page => page, :per_page => 10).order('name ASC')
  end

  def self.to_csv(options = {})
    desired_columns = ["id", "name", "linked_client", "email", "telephone", "date_of_birth", "active","trial_class", "uniform_promotion"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |student|
        csv << student.attributes.values_at(*desired_columns)
      end
    end
  end

end
