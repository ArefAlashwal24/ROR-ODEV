# frozen_string_literal: true
﻿class User < ApplicationRecord
  has_many :posts,    dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
