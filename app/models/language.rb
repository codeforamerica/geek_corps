class Language < ActiveRecord::Base
  belongs_to :polyglot, :polymorphic => true
end
