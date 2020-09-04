GAME_BORDER_SPRITE = 'sprites/game_border.png'


ROOM_BORDER_SPRITE = 'sprites/map_tile.png'
PLAYER_STANDING_SPRITE_PATH = 'sprites/player_standing.png'
PLAYER_LEFT_LEG_DOWN_SPRITE_PATH = 'sprites/player_move_0.png'
PLAYER_RIGHT_LEG_DOWN_SPRITE_PATH = 'sprites/player_move_1.png'
PLAYER_SPRITE_SHEET_PATH = 'sprites/player_sheet.png'

QUESTION_MARK_SPRITE_PATH = 'sprites/question_mark.png'

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

NAMES_SIZE = 6
NAMES = ["Terrible",
         "Poor",
         "Unremarkable",
         "Acceptable",
         "Exceptional",
         "Glorious"]

TYPES_SIZE = 4
TYPES = ["Sword", "Axe", "Hammer", "Fist"]

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

def player_default_sprite
  {
    x: 576,
    y: 296,
    w: PLAYER_SPRITE_W, 
    h: PLAYER_SPRITE_H,
    path: PLAYER_STANDING_SPRITE_PATH
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
