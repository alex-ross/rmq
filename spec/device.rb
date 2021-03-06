describe 'device' do
  before do
    @rmq = RubyMotionQuery::RMQ
  end

  it 'should return device from RMQ or an instance of rmq' do
    @rmq.device.should == RubyMotionQuery::Device

    rmq = RubyMotionQuery::RMQ.new
    rmq.device.should == RubyMotionQuery::Device
  end

  it 'should have a screen' do
    @rmq.device.screen.should == UIScreen.mainScreen
  end

  it 'should return the proper width' do
    @rmq.device.width.should == UIScreen.mainScreen.bounds.size.width
  end

  it 'should return the proper height' do
    @rmq.device.height.should == UIScreen.mainScreen.bounds.size.height
  end

  it 'should return the proper value for ipad?' do
    @rmq.device.ipad?.should == false

    class RubyMotionQuery::Device
      def self.fake_ipad; @_ipad = true; end
    end

    @rmq.device.fake_ipad
    @rmq.device.ipad?.should == true
  end

  it 'should return true for iphone?' do
    @rmq.device.iphone?.should == true

    class RubyMotionQuery::Device
      def self.fake_iphone; @_iphone = false; end
    end

    @rmq.device.fake_iphone
    @rmq.device.iphone?.should == false
  end

  it 'should return the right value for simulator?' do
    @rmq.device.simulator?.should == true

    class RubyMotionQuery::Device
      def self.fake_simulator_value; @_simulator = false; end
    end

    @rmq.device.fake_simulator_value
    @rmq.device.simulator?.should == false
  end

  it 'should return the right value for four_inch?' do
    @rmq.device.four_inch?.should == true

    class RubyMotionQuery::Device
      class << self
        def fake_height(value)
          @_four_inch = nil
          @_height = value
        end

        def reset_fake_caches
          @_four_inch = nil
          @_height = nil
        end
      end
    end

    @rmq.device.fake_height(10)
    @rmq.device.four_inch?.should == false
    @rmq.device.reset_fake_caches
  end

  describe 'retina?' do
    #TODO finish
  end

  describe 'landscape?' do
    #TODO finish
  end

  describe 'portrait?' do
    #TODO finish
  end

  describe 'orientations' do
    #TODO finish
  end

  it 'contains "unknown" in device orientations' do
    RubyMotionQuery::Device.orientations[UIDeviceOrientationUnknown].should.not == nil
  end
end
