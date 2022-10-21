# frozen_string_literal: true

# base application model
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
