require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }
  it { is_expected.to belong_to :user }

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has unique name' do
    Restaurant.create(name: "Moe's Tavern")
    restaurant = Restaurant.new(name: "Moe's Tavern")
    expect(restaurant).to have(1).error_on(:name)
  end


  describe '#average_rating' do
    context 'no reviews' do
      it "returns 'N/A' when there are no reviews" do
        restaurant = Restaurant.create(name: 'The Oak')
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end
    context '1 review' do
      it "returns avg rating" do
        restaurant = Restaurant.create(name: 'Honest Burguer')
        restaurant.reviews.create(rating: 4)
        expect(restaurant.average_rating).to eq 4
      end
    end
    context 'several reviews' do
      it "returns avg rating" do
        user1=User.create(email: 'ss@gmail.com', password: 'holacaracola', password_confirmation: 'holacaracola')
        user2=User.create(email: 'ds@gmail.com', password: 'caracaracola', password_confirmation: 'caracaracola')
        restaurant = Restaurant.create(name: 'Yauatcha')
        restaurant.reviews.create(rating: 1, user_id: user1.id)
        restaurant.reviews.create(rating: 5, user_id: user2.id)
        expect(restaurant.average_rating).to eq 3.0
      end
    end
  end

end
