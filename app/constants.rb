GAME_BORDER_SPRITE = 'sprites/game_border.png'


ROOM_BORDER_SPRITE = 'sprites/map_tile.png'
PLAYER_STANDING_SPRITE_PATH = 'sprites/player_standing.png'
PLAYER_LEFT_LEG_DOWN_SPRITE_PATH = 'sprites/player_move_0.png'
PLAYER_RIGHT_LEG_DOWN_SPRITE_PATH = 'sprites/player_move_1.png'
PLAYER_UP_STANDING_SPRITE_PATH = 'sprites/player_up_standing.png'
PLAYER_LEFT_STANDING_SPRITE_PATH = 'sprites/player_left_standing.png'
PLAYER_RIGHT_STANDING_SPRITE_PATH = 'sprites/player_right_standing.png'
PLAYER_SPRITE_SHEET_PATH = 'sprites/player_sheet.png'

QUESTION_MARK_SPRITE_PATH = 'sprites/question_mark.png'

MENU_BORDER_SPRITE = 'sprites/menu_border.png'

INITIAL_SELECT_BORDER_SPRITE = 'sprites/initial_item_select.png'

PLAYER_SPRITE_X = 576
PLAYER_SPRITE_Y = 268
PLAYER_SPRITE_W = 128
PLAYER_SPRITE_H = 128
ROOM_BORDER_SPRITE_W = 144
ROOM_BORDER_SPRITE_H = 144
PLAYER_SPEED_LIMIT = 5
PLAYER_ACCEL = 0.5
PLAYER_FRICT = 0.9
DSPWN_RNG = 50
TRACING_ENABLED = false

NAMES_SIZE = 3
NAMES = ["poor",
         "fair",
         "fine"]

TYPES_SIZE = 3
TYPES = ["sword", "axe", "hammer"]

EXAMPLE_MAP =
  [0,0,0,0,0,0,0,0,0,0,
   0,0,0,0,0,3,0,0,0,0,
   0,0,0,0,1,1,0,0,0,0,
   0,0,0,0,1,0,1,0,0,0,
   0,0,0,0,2,1,1,1,0,0,
   0,0,0,1,1,1,0,1,0,0,
   0,0,0,0,1,0,0,1,0,0,
   0,0,0,0,1,0,1,1,0,0,
   0,0,0,0,1,1,1,0,0,0,
   0,0,0,0,0,0,0,0,0,0]


def game_border_sprite
  {
    x: 384,
    y: 104,
    w: 512,
    h: 512,
    path: GAME_BORDER_SPRITE
  }
end

def player_down_standing
  {
    x: 576,
    y: 296,
    w: PLAYER_SPRITE_W, 
    h: PLAYER_SPRITE_H,
    path: PLAYER_STANDING_SPRITE_PATH
  }
end

def player_down_move_0
  {
    x: 576,
    y: 296,
    w: PLAYER_SPRITE_W, 
    h: PLAYER_SPRITE_H,
    path: PLAYER_LEFT_LEG_DOWN_SPRITE_PATH
  }
end

def player_up_standing
  {
    x: 576,
    y: 296,
    w: PLAYER_SPRITE_W, 
    h: PLAYER_SPRITE_H,
    path: PLAYER_UP_STANDING_SPRITE_PATH
  }
end

def player_left_standing
  {
    x: 576,
    y: 296,
    w: PLAYER_SPRITE_W, 
    h: PLAYER_SPRITE_H,
    path: PLAYER_LEFT_STANDING_SPRITE_PATH
  }
end

def player_right_standing
  {
    x: 576,
    y: 296,
    w: PLAYER_SPRITE_W, 
    h: PLAYER_SPRITE_H,
    path: PLAYER_LEFT_STANDING_SPRITE_PATH,
    flip_horizontally: true
  }
end

def room_border_sprite
  {
    x: 568, #this will need to change to a variable
    y: 288,
    w: ROOM_BORDER_SPRITE_W, 
    h: ROOM_BORDER_SPRITE_H,
    path: ROOM_BORDER_SPRITE
  }
end

def question_mark_sprite
  {
    x: 568, #this will need to change to a variable
    y: 432,
    w: ROOM_BORDER_SPRITE_W, 
    h: ROOM_BORDER_SPRITE_H,
    path: QUESTION_MARK_SPRITE_PATH
  }
end

def menu_border_sprite
  {
    x: 448, #this will need to change to a variable
    y: 232,
    w: 384, 
    h: 256,
    path: MENU_BORDER_SPRITE
  }
end

def initial_select_border_sprite
  {
    x: 640+2*8,
    y: 360-16*8,
    w: 16*8, 
    h: 16*8,
    path: INITIAL_SELECT_BORDER_SPRITE
  }

  def set_x x
    @x = x
  end
end
