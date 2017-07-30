# frozen_string_literal: true

class Department < ApplicationRecord
  has_many :users, dependent: :nullify
  validates :name, presence: true
end
