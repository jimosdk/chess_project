require_relative 'board.rb'
require 'byebug'
require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [1, 0],
  down: [-1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board, :selected

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = nil
  end

  def get_input(color)
    key = KEYMAP[read_char]
    handle_key(key,color)
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key,color)
    case key
    when :up,:down,:right,:left
        update_pos(MOVES[key])
    when :return,:space
        return toggle_selected(@cursor_pos,color)
    when :ctrl_c
        Process.exit(0)
    end
    nil
  end

  def update_pos(diff)
    row,col = @cursor_pos
    dx,dy = diff
    new_pos = [row + dx , col + dy]
    @cursor_pos = new_pos if @board.valid_pos?(new_pos)
  end

  def toggle_selected(pos,color)
    return nil if @selected.nil? && @board.empty?(pos)
    if @selected.nil? && @board[pos].color != color
      puts "It's #{color} player's turn"              #reminder : make standard error
      return nil 
    end
    @selected = @selected.nil? ? pos : nil 
    @cursor_pos
  end

end