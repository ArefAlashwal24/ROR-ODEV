# frozen_string_literal: true
﻿class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :body, presence: true
end
