require "Sphero"
require 'io/console'

def roll_right
  Sphero.start '/dev/tty.Sphero-WRO-AMP-SPP' do
    roll 300, 90
    keep_going 1
  end
end

def roll_left
  Sphero.start '/dev/tty.Sphero-WRO-AMP-SPP' do
    roll 20, 270
    keep_going 1
  end
end

def roll_front
  Sphero.start '/dev/tty.Sphero-WRO-AMP-SPP' do
    roll 20, 0
    keep_going 1
  end
end

def roll_back
  Sphero.start '/dev/tty.Sphero-WRO-AMP-SPP' do
    roll 20, 180
    keep_going 1
  end
end

def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end

def command_sphero
  puts 'INPUT:'
  char = read_char

  # Sphero.start '/dev/tty.Sphero-WRO-AMP-SPP' do
  case char
  when "\e[A"
    puts "UP ARROW"
    roll_front
  when "\e[B"
    puts "DOWN ARROW"
    roll_back
  when "\e[C"
    puts "RIGHT ARROW"
    roll_right
  when "\e[D"
    puts "LEFT ARROW"
    roll_left
  when "\u0003"
    abort "RECEIVED INTERRUPT"
  else
    puts "NO COMMAND REGSTERED FOR: #{char.inspect}"
  end
  # end
end

command_sphero while(true)
