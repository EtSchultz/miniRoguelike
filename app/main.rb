require 'app/constants.rb'

class Player
  attr_accessor :pos, :sprite, :inv, :hp, :last_step

  def initilize
    @pos = 0
    @inv = ["Fist", "Fist"]
    @hp = 100
    @sprite = player_default_sprite
    @last_step = 1
  end
  
end

class Item
  attr_accessor :name, :dmg, :type

  def initialize(name, type, dmg)
    @type = type
    @name = name
    @dmg = dmg
  end

  def use_fist
    @type = "Fist"
    @name = "Fist"
    @dmg = 5
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
  attr_accessor :pos, :enemy, :item, :is_open, :is_starting, :is_end

  def initialize(pos, enemy, item, is_starting, is_end)
    @pos = pos
    @enemy = enemy
    @item = item
    @is_starting = is_starting
    @is_end = is_end
    @is_open = false
  end

  def class
    Room
  end

end

class Game
  attr_accessor :player, :args, :state, :rooms, :inputs, :outputs, :grid, :seed, :map_generated

  def initialize
    @rooms ||= []
    load_example_map
    @player ||= Player.new
    place_player_starting
  end
  
  def tick
    #trace!
    render_canvas
    #render_map
    render_player
    #print_cell_coordinates
    #calc_canvas
    #input_move
    #input_click_map
    draw_adjacent_rooms
  end

  def render_player
    outputs.sprites << player_default_sprite
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

    Item.new(NAMES[0], TYPES[0], 10)
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
        return
      end
    end
  end

  def draw_adjacent_rooms
    #north
    if @rooms.detect { |r| r.pos == (@player.pos+10)} != nil
      outputs.sprites << [576, 432, PLAYER_SPRITE_W,PLAYER_SPRITE_H, QUESTION_MARK_SPRITE_PATH]
    end
    #south
    if @rooms.detect { |r| r.pos == (@player.pos-10)} != nil
      outputs.sprites << [576, 160, PLAYER_SPRITE_W,PLAYER_SPRITE_H, QUESTION_MARK_SPRITE_PATH]
    end
    #east
    if @rooms.detect { |r| r.pos == (@player.pos+1)} != nil
      outputs.sprites << [712, 296, PLAYER_SPRITE_W,PLAYER_SPRITE_H, QUESTION_MARK_SPRITE_PATH]
    end
    #west
    if @rooms.detect { |r| r.pos == (@player.pos-1)} != nil
      outputs.sprites << [440, 296, PLAYER_SPRITE_W,PLAYER_SPRITE_H, QUESTION_MARK_SPRITE_PATH]
    end
  end
    
  def input_move
    
  end
end

$game = Game.new

def tick args
  $game.seed ||= $game.gen_seed
  
  #$game.args    = args
  #$game.state   = args.state
  #$game.inputs  = args.inputs
  $game.outputs = args.outputs
  #$game.grid    = args.grid
  $game.tick
  args.outputs.labels << [256,512,$game.seed,4,1,255,255,255,255, 'fonts/PICO-8 mono.ttf']
end
