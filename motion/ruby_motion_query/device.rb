module RubyMotionQuery
  class RMQ
    # @return [Device]
    def device
      Device
    end

    # @return [Device]
    def self.device
      Device
    end
  end

  class Device
    class << self
      # @return [UIScreen]
      def screen
        UIScreen.mainScreen
      end

      # @return [Numeric]
      def width
        @_width ||= Device.screen.bounds.size.width
      end

      # @return [Numeric]
      def height
        @_height ||= Device.screen.bounds.size.height
      end

      def screen_width
        portrait? ? screen.bounds.size.width : screen.bounds.size.height
      end

      def screen_height
        portrait? ? screen.bounds.size.height : screen.bounds.size.width
      end

      def ipad?
        @_ipad = (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) if @_ipad.nil?
        @_ipad
      end

      def iphone?
        @_iphone = (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) if @_iphone.nil?
        @_iphone
      end

      def simulator?
        @_simulator = !(UIDevice.currentDevice.model =~ /simulator/i).nil? if @_simulator.nil?
        @_simulator
      end

      def four_inch?
        @_four_inch = (Device.height == 568.0) if @_four_inch.nil?
        @_four_inch
      end

      def retina?
        if @_retina.nil?
          main_screen = Device.screen
          @_retina = !!(main_screen.respondsToSelector('displayLinkWithTarget:selector:') && main_screen.scale == 2.0)
        end

        @_retina
      end

      # @return :unknown or from ORIENTATIONS
      def orientation
        orientation = UIApplication.sharedApplication.statusBarOrientation
        ORIENTATIONS[orientation] || :unknown
      end

      def landscape?
        Device.orientation == :landscape_left || Device.orientation == :landscape_right
      end

      def portrait?
        Device.orientation == :portrait || Device.orientation == :unknown
      end

      def orientations
        ORIENTATIONS
      end

      ORIENTATIONS = {
        UIDeviceOrientationUnknown => :unknown,
        UIDeviceOrientationPortrait => :portrait,
        UIDeviceOrientationPortraitUpsideDown => :portrait_upside_down,
        UIDeviceOrientationLandscapeLeft => :landscape_left,
        UIDeviceOrientationLandscapeRight => :landscape_right,
        UIDeviceOrientationFaceUp => :face_up,
        UIDeviceOrientationFaceDown => :face_down
      }

    end
  end
end
