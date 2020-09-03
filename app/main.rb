require 'app/constants.rb'

class Player
  attr_accessor :pos, :sprite, :inv, :hp#, :last_step

  def initilize(pos)
    @pos = pos
    @inv = ["Fist", "Fist"]
    @hp = 100
    @sprite = player_sprite
    #@last_step = 
  end

  def sprite
    @sprite
  end
  
end

class Item
  attr_accessor :name, :dmg, :type

  def initialize(seed, level)
   # @type = gen_type(seed, level)
   # @name = gen_name(seed, level)
    #@dmg = gen_dmg(seed, level)
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
end

class Game
  attr_accessor :player, :args, :state, :inputs, :outputs, :grid, :seed

  def tick
    defaults
    render_canvas
    #render_map
    render_player
    #print_cell_coordinates
    #calc_canvas
    #input_move
    #input_click_map
  end

  def defaults

    state.map  ||= EXAMPLE_MAP #[]
    state.level ||= 1
    #state.rooms   ||= []

  end

  def render_player
    outputs.sprites << player_sprite
  end
  
  def render_canvas
    outputs.background_color = [0,0,0]
    outputs.sprites << game_border_sprite
    outputs.sprites << room_border_sprite
  end

  
  
  #def gen_map

  #end
  
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

  #def input_move
    
  #end
end

$game = Game.new

def tick args
  $game.seed ||= $game.gen_seed
  
  #$game.args    = args
  $game.state   = args.state
  #$game.inputs  = args.inputs
  $game.outputs = args.outputs
  #$game.grid    = args.grid
  $game.tick
  args.outputs.labels << [100,600,$game.seed,1,1,255,255,255,255]
end
