require "Sphero"
require 'io/console'

def roll_right
  roll 25, 270
end

def roll_left
  roll 25, 90
end

def roll_front
  roll 25, 0
end

def roll_back
  roll 25, 180
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
  char = read_char

  Sphero.start '/dev/tty.Sphero-WRO-AMP-SPP' do
    case char
    when "\e[A"
      #puts "UP ARROW"
      roll_front
    when "\e[B"
      #puts "DOWN ARROW"
      roll_back
    when "\e[C"
      #puts "RIGHT ARROW"
      roll_right
    when "\e[D"
      #puts "LEFT ARROW"
      roll_left
    else
      puts "NO COMMAND REGSTERED FOR: #{c.inspect}"
    end
  end
end

command_sphero while(true)
