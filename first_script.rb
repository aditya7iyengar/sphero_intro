require "Sphero"

Sphero.start '/dev/tty.Sphero-WRO-AMP-SPP' do
    # Roll 0 degrees, speed 125
    x = 0
    while x < 30 do
        roll 500, 60

        # # Turn 360 degrees, 30 degrees at a time
        # 0.step(360, 30) { |h|
        # h = 0 if h == 360

        #     # Set the heading to h degrees
        #     heading = h
        #     keep_going 1
        # }

        keep_going 1

        x += 30
        # stop
    end
end
