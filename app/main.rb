require 'app/constants.rb'

class Integer
  def to_roman
    roman_arr = {
      1000 => "m",
      900 => "cm",
      500 => "d",
      400 => "cd",
      100 => "c",
      90 => "xc",
      50 => "l",
      40 => "xl",
      10 => "x",
      9 => "ix",
      5 => "v",
      4 => "iv",
      1 => "i"
    } 
    num = self

    roman_arr.reduce("") do |res, (arab, roman)|
      whole_part, num = num.divmod(arab)
      res << roman * whole_part
    end
  end
end

class Player
  attr_accessor :pos, :sprite, :inv, :hp, :last_step

  def initilize
    @pos = 0
    @inv = ["Fist", "Fist"]
    @hp = 100
    @sprite = player_default_sprite
    @steps = 0
  end
  
end

class Menu_Select
  attr_accessor :x, :y, :w, :h, :path

  def initialize(x, y, w, h, path)
    @x = x
    @y = y
    @w = w
    @h = h
    @path = path
  end

  def sprite
    return [@x, @y, @w, @h, @path]
  end

end

class Item
  attr_accessor :name, :dmg, :type, :level

  def initialize(name, type, dmg, level)
    @type = type
    @name = name
    @dmg = dmg
    @level = level
  end

  #def gen_type(seed, level)
    
  #end
  
  #def gen_name(seed, level)
    
  #end
end

class Enemy
  attr_accessor :name, :type, :item, :dmg, :level

  def initialize(name)
    @name = name
  end
end

class Room
  attr_accessor :pos, :enemy, :item, :is_visited, :is_starting, :is_end

  def initialize(pos, enemy, item, is_starting, is_end)
    @pos = pos
    @enemy = enemy
    @item = item
    @is_starting = is_starting
    @is_end = is_end
    @is_visited = false
  end

  def class
    Room
  end

end

class Game
  attr_accessor :player, :args, :state, :rooms, :inputs, :outputs, :grid, :seed, :map_generated, :in_menu, :item_menu, :level, :curr_menu_select

  def initialize
    @level ||= 1
    @rooms ||= []
    load_example_map
    @player ||= Player.new
    place_player_starting
    set_player_sprite
    @in_menu = false
    @curr_menu_select ||= Menu_Select.new(640+5*8, 360-16*8, 16*8, 16*8, INITIAL_SELECT_BORDER_SPRITE)
    
  end
  
  def tick
    #trace!
    render_canvas
    #render_map
    render_player
    #print_cell_coordinates
    #calc_canvas
    input_move
    #input_click_map
    draw_adjacent_rooms
    if @in_menu == true
      initial_item_select_menu
    end
  end

  def set_player_sprite
    @player.sprite = player_down_standing
  end

  def render_player
    outputs.sprites << @player.sprite
  end

  def render_canvas
    outputs.background_color = [0,0,0]
    outputs.sprites << game_border_sprite

    outputs.sprites << room_border_sprite

  end

  #def gen_map

  #end

  def roll_item
    intseed = @seed.to_i

    #roll items based on @level

    return Item.new(NAMES[rand(NAMES_SIZE)], TYPES[rand(TYPES_SIZE)], 10, @level)
  end
  
  def gen_seed
    chars = "0123456789"
    curr = rand(14)

    i=0
    str = ""
    while i < 8 do
      curr = rand(9)
      str += chars[curr]
      i+=1
    end
    puts str
    seed = str
  end

  def load_example_map
    i = 0
    for room_num in EXAMPLE_MAP
      if room_num != 0
        #puts room_num
        @rooms << Room.new(i,Enemy.new("nil"),roll_item, room_num == 2, room_num == 3)
      end
      i+=1
    end
    true
  end

  def place_player_starting
    for room in @rooms
      puts room.pos
      if room.is_starting
        @player.pos = room.pos
        @rooms.find{ |r| r.pos == (@player.pos)}.is_visited = true
        return
      end
    end
  end

  def draw_adjacent_rooms
    #i moved the north and south by one sim pixel away in y from player because it looks nicer
    #if it makes placement harder just revert it
    #north
    if @rooms.detect { |r| r.pos == (@player.pos+10) and not r.is_visited} != nil
      outputs.sprites << [576, 440, PLAYER_SPRITE_W,PLAYER_SPRITE_H, QUESTION_MARK_SPRITE_PATH]
    elsif @rooms.detect { |r| r.pos == (@player.pos+10) and r.is_visited} != nil
      outputs.sprites << [568, 442, ROOM_BORDER_SPRITE_W,ROOM_BORDER_SPRITE_H, ROOM_BORDER_SPRITE]
    end
    #south
    if @rooms.detect { |r| r.pos == (@player.pos-10) and not r.is_visited} != nil
      outputs.sprites << [576, 152, PLAYER_SPRITE_W,PLAYER_SPRITE_H, QUESTION_MARK_SPRITE_PATH]
    elsif @rooms.detect { |r| r.pos == (@player.pos-10) and r.is_visited} != nil
      outputs.sprites << [568, 134, ROOM_BORDER_SPRITE_W,ROOM_BORDER_SPRITE_H, ROOM_BORDER_SPRITE]
    end
    #east
    if @rooms.detect { |r| r.pos == (@player.pos+1) and not r.is_visited} != nil
      outputs.sprites << [712, 296, PLAYER_SPRITE_W,PLAYER_SPRITE_H, QUESTION_MARK_SPRITE_PATH]
    elsif @rooms.detect { |r| r.pos == (@player.pos+1) and r.is_visited} != nil
      outputs.sprites << [722, 288, ROOM_BORDER_SPRITE_W,ROOM_BORDER_SPRITE_H, ROOM_BORDER_SPRITE]
    end
    #west
    if @rooms.detect { |r| r.pos == (@player.pos-1) and not r.is_visited} != nil
      outputs.sprites << [440, 296, PLAYER_SPRITE_W,PLAYER_SPRITE_H, QUESTION_MARK_SPRITE_PATH]
    elsif @rooms.detect { |r| r.pos == (@player.pos-1) and r.is_visited} != nil
      outputs.sprites << [414, 288, ROOM_BORDER_SPRITE_W,ROOM_BORDER_SPRITE_H, ROOM_BORDER_SPRITE]
    end
  end

  def draw_item_menu

    
    item = @rooms.find{ |r| r.pos == (@player.pos)}.item
    outputs.sprites << menu_border_sprite
    
    outputs.labels << [640-21*8,360+14*8,"you found a",8,0,255,255,255,255, 'fonts/PICO-8 mono.ttf']
    outputs.labels << [640-21*8,360+9*8,"level #{item.level.to_roman}",8,0,255,255,255,255, 'fonts/PICO-8 mono.ttf']
    outputs.labels << [640-21*8,360+4*8,"#{item.name + " " + item.type}",8,0,255,255,255,255, 'fonts/PICO-8 mono.ttf']

    outputs.labels << [640-20*8,360-5*8,"drop",8,0,255,255,255,255, 'fonts/PICO-8 mono.ttf']
    outputs.labels << [640+6*8,360-5*8,"take",8,0,255,255,255,255, 'fonts/PICO-8 mono.ttf']

    outputs.sprites << @curr_menu_select.sprite

    if inputs.keyboard.key_down.e
      @in_menu = false
      
    end
  end

  def enter_new_room nextRoom
    if nextRoom.item != nil
      @in_menu = true
    end
  end

  def initial_item_select_menu
    
    if inputs.keyboard.key_down.a
      @curr_menu_select = Menu_Select.new(640-21*8, 360-16*8, 16*8, 16*8, INITIAL_SELECT_BORDER_SPRITE)
    elsif inputs.keyboard.key_down.d
      @curr_menu_select = Menu_Select.new(640+5*8, 360-16*8, 16*8, 16*8, INITIAL_SELECT_BORDER_SPRITE)
    end
    draw_item_menu
  end
      
  def input_move
    #change player sprite to correct move image based on steps. move question mark up until 360 y
    #move along then swap sprite placement. update player.pos
    if not in_menu
      if inputs.keyboard.key_down.s
        if @rooms.detect { |r| r.pos == (@player.pos-10)} != nil
          @player.sprite = player_down_standing
          nextRoom = @rooms.find{ |r| r.pos == (@player.pos-10)}
          if not nextRoom.is_visited == true
            enter_new_room nextRoom
          end
          nextRoom.is_visited = true
          @player.pos -= 10
        end
      elsif inputs.keyboard.key_down.w
        if @rooms.detect { |r| r.pos == (@player.pos+10)} != nil
          @player.sprite = player_up_standing
          nextRoom = @rooms.find{ |r| r.pos == (@player.pos+10)}
          if not nextRoom.is_visited
            enter_new_room nextRoom
          end
          nextRoom.is_visited = true
          @player.pos += 10
        end
      elsif inputs.keyboard.key_down.a
        if @rooms.detect { |r| r.pos == (@player.pos-1)}
          @player.sprite = player_left_standing
          nextRoom = @rooms.find{ |r| r.pos == (@player.pos-1)}
          if not nextRoom.is_visited
            enter_new_room nextRoom
          end
          nextRoom.is_visited = true
          @player.pos -= 1
        end
      elsif inputs.keyboard.key_down.d
        if @rooms.detect { |r| r.pos == (@player.pos+1)} != nil
          @player.sprite = player_right_standing
          nextRoom = @rooms.find{ |r| r.pos == (@player.pos+1)}
          if not nextRoom.is_visited
            enter_new_room nextRoom
          end
          nextRoom.is_visited = true
          @player.pos += 1
        end
      end
    end
  end
  
end

$game = Game.new

def tick args
  $game.seed ||= $game.gen_seed
  
  $game.args    = args
  $game.state   = args.state
  $game.inputs  = args.inputs
  $game.outputs = args.outputs
  #$game.grid    = args.grid
  $game.tick
  args.outputs.labels << [256,512,$game.seed,8,1,255,255,255,255, 'fonts/PICO-8 mono.ttf']
end
