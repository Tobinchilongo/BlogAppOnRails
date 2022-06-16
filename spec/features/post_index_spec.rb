require 'rails_helper'

RSpec.feature 'PostIndex', type: :feature do
  before do
    @user = create(:user)
  end
end
