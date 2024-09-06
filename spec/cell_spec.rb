require 'spec_helper'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new('B4')
    @cruiser = Ship.new('Cruiser', 3)
  end

  it 'exists' do
    expect(@cell).to be_instance_of(Cell)
  end

  describe '#initialize' do
    it 'has a coordinate' do
      expect(@cell.coordinate).to eq('B4')
    end
  end

  describe '#ship' do
    it 'does not have a ship' do
      expect(@cell.ship.nil?).to eq(true)
    end

    it 'has a ship' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)
    end
  end

  describe '#place_ship' do
    it 'can place a ship' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to be_instance_of(Ship)
      expect(@cell.ship).to eq(@cruiser)
    end
  end

  describe '#empty' do
    it 'is empty' do
      expect(@cell.empty?).to eq(true)
    end

    it 'is not empty' do
      @cell.place_ship(@cruiser)
      expect(@cell.empty?).to eq(false)
    end
  end

  describe '#fired_upon?' do
    it 'is not hit' do
      @cell.place_ship(@cruiser)
      expect(@cell.fired_upon?).to eq(false)
    end

    it 'is hit' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      expect(@cell.fired_upon?).to eq(true)
    end
  end

  describe '#renderd' do
    it 'can render empty' do
      expect(@cell.render).to eq('.')
    end

    it 'can render miss' do
      @cell.fire_upon
      expect(@cell.render).to eq('M')
    end

    it 'can render hit' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      expect(@cell.render).to eq('H')
    end

    it 'can render a ship' do
      @cell.place_ship(@cruiser)
      expect(@cell.render(true)).to eq('S')
    end

    it 'can render sink' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      @cruiser.hit
      @cruiser.hit
      @cruiser.hit
      expect(@cell.render).to eq('X')
    end
  end
end
