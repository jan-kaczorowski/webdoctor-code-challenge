class User < ApplicationRecord
  has_one :inbox, dependent: :destroy
  has_one :outbox, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :messages, dependent: :destroy

  scope :patient, -> { where(is_patient: true) }
  scope :admin, -> { where(is_admin: true) }
  scope :doctor, -> { where(is_doctor: true) }

  def self.current
    User.patient.first
  end

  def self.default_admin
    User.admin.first
  end

  def self.default_doctor
    User.doctor.first
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  first_name :string
#  is_admin   :boolean          default(FALSE), not null
#  is_doctor  :boolean          default(FALSE), not null
#  is_patient :boolean          default(TRUE), not null
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
