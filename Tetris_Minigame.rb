($imported ||= {})[:GGZiron_Tetris] = true
module GGZiron_Tetris
  
=begin
                 About the Script:
 Author: GGZiron.
 Name: Tetris Mini Game
 Engine: RPG Maker VX ACE
 Version 1.0.6
 Terms of use: Free for comercial and non comercial project. Free to edit,
 but keep my part of the header, and don't claim the script is yours.
 You have to credit me as GGZiron.
 
 The idea to make tetris script came from Neo_Kum0rius_6000's script request 
 thread, although I started my tetris several months later. 
 
 If you see any bug, or have suggestion, you can post on this script thread on
 RPG Maker forum, or pm me.
 
 Version History
 1.0.0: Initial Release on 02/07/2019.
 1.0.1: Released on 03/07/2019. 
   *Fixed a typo I noticed in one of the strings.
   *Removed two unnecessary operations I did in the Audio module.
 1.0.2: Released on 03/07/2019
   *Readded the "unncecessary" operations, and fixed an issue they had
    in initial version.
 1.0.3: Released on 04/07/2019
   *Fixed new possible issues with the Audio module.
   *Fixed an issue where clearing the required number of lines sometimes 
    would not increase the hardship level.
 1.0.4: Released on 04/07/2019
   *Now disposing properly a lot of graphical objects, which it wasn't
    previously. Found about it while using Mithran's debugger script.
 1.0.5: Released on 07/07/2019
   *Performance update. In previous version, all stats (level, deleted lines,
    scores, etc) were redrawn whenever one of them changes, causing some lag.
    Now, it redraws only the part that needs to be redrawn, as it should be.
    Did other improvements too.
 1.0.6 Released on 07/07/2019
   *Cleared one visual bug, that came with 1.0.5, and failed to detect it
    initially.
   
 Script Purpose: Adds the game Tetris as minigame into your RPG maker game.
 That happens on it's own scene. As classical Tetris, it has 9 levels, and the
 last one is endless.
 
 Hardship to use : Vary.
 If you are happy with my Tetris as it is, then is plug and play. Easy.
 But if you are not, then there are lot of settings, including redesign of 
 Tetris Scene. Doing something with them might not be as easy, but may make your
 version of the tetris little bit more unique, or better fit to your RPG game.
 
 Compatibility: Will avoid to grade it, but will say what I did for it.
 Most of my data, scenes and windows plus logics are inside my own module, 
 so I avoid name conflicting. But there are methods I overwrite (which I alias
 first), and methods I add into the original classes. With the purpose to avoid
 name conflict, the aliased method names have attached digits to them.
 Among all other stuffs I modify, I modify the Audio module too, so I am able
 to remember last music and background sound playing before the player run
 the Tetris Minigame. That very needed to be able to restore them once player
 exit tetris. It might not go well with other scripts that are playing with the 
 audio. 
 Some additional information about my tetris:
 
 As clasical Tetris, it has 9 levels, and the last one is endless.
 Visually, it tries to look a little bit like clasic tetris with blocks.
 Once blocks are spawned upon, shaping a field, they never move, they only 
 change colors, forming tetromino figures, that looks like moving, rotating and 
 falling down with certain speed. All that is achieved via controlled recoloring.
 
 Tetrominoes spawn order is as follows: There is virtual bag ( array ) of all 7 
 pieces plus one fully random piece, which make bag of 8 pieces. Those pieces 
 will be spawned on random order. After each spawn, the spawning is removed
 from the bag. Once the bag is empty, it will be reset.
 That means each piece type will be spawn at least once per every 8 spawned
 piece types, as one of them will be spawned twice. Also it means that
 a piece type is possible to be spawned 4 times in row. That can occure 
 if the given piece and the random piece are last 2 of their respective bag, 
 but first two of next bag, and the random piece happens to be the same as 
 other one.
 
 The script provides music background(with settings about it), sound effects,
 certain data to be extracted via script calls upon main RPG game, if you
 want to reward or punish the player. Also it providers vocab settings, where
 you can change basically all the text strings that are coming from this script.
 Game visuals can be altered: each piece have color, set via rgb code, you
 can set also backgrounds color or background picture. You can alter window
 sizes, window positions, their opacity, font sizes in them and more.
 
 Some flaws on my script: 
 For some stuffs I use my own methods than standard methods provided from 
 the very engine. Is not because I find my methods superior, but because I am 
 not too familiar with all engine's methods, and how exactly they work. 
 In future, if find time, may improve my script on that. As that is initial 
 version, bugs are possible to happen(although is every programmer dream that 
 they don't). Some of my methods to achieve things could be longer
 (and unortodoxal, aka amateurish), which also makes them cumbersome. 
 In future, if I release new version, probably would optimize my code as well. 
 Also, if I get reports for desired settings that aren't here, and I
 am able to add them and I aprove to have them in my tetris, I would.
 As long I have the time for it.
 
 As said above, bug reports are welcome.
 
 Flashy visuals aren't my forte, which means many could see my tetris lacking
 on visual department. 
 
=end
  
# ===========================================================================
#                            WAY TO USE:
# ===========================================================================

# One way to run the Tetris is via the main menu, if playing Tetris from there
# is enabled (it is by default, but can be changed in settings).

# You can also run it with script call, using this:
# scene = GGZiron_Tetris::Scene_Tetris
# SceneManager.call(scene)

# ===========================================================================
#                             SETTINGS:
# ===========================================================================

# I divide the settings on different categories. 
# Read carefully the instructions, before you change something.

# ===========================================================================
#                         GENERAL OPTIONS
# ===========================================================================

  LINES_PER_LEVEL = 15
# How many lines the player must clear for hardship level to increase.
   
  BEST_SCORES_TEXT_COLOR = 2
# Uses the colors set from Graphics/System/Window.png.
# The colors are in the bottom right corner of the png
# file, as each color have index, starting from 0. The default 
# value of 2 with default Window.png would produce orange text color.

  @menu_tetris_enabled = true #Enables tetris play from menu, if true.
  @menu_tetris_display = true #Displays play tetris option in menu, if true.
# You can change the above two settings any time in game, with the
# following script calls:
# GGZiron_Tetris.menu_tetris_enabled = boolean value ( must be true or false)
# GGZiron_Tetris.menu_tetris_display = boolean value ( must be true or false)
# Examples:
# GGZiron_Tetris.menu_tetris_display = false
# GGZiron_Tetris.menu_tetris_display = true
   
# ==========================================================================
#                          GAME OVER HANDLING
# ==========================================================================

# The tetris have it's own game over handling

  GAME_LOCK = 7
# How many seconds the game over window will lock the player input.
# The game over ME can play for that time without the user being able
# to interupt it.
# Use integers(whole numbers), not decimals. 
 
# For game over music effect, see the audio settings part of the settings.
 
# ===========================================================================
#                          TIME FLOW OPTIONS
# ===========================================================================

# The tetris speed flow tries not to depends on the frame rate of the game.
# The values given bellow are in seconds.
# The actual time might vary with small fragmet of the second with the time
# you set.

  BASE_FALL_SPEED = 1.22
# The base fall speed is the slowest speed, with which the piece will fall.
# That will be the initial speed at level 1. With each next level,
# the actual speed will be result of that speed devided on the current level.
  
  MOVE_SENSITIVITY = 0.12
# When moving the piece left or right, it waits as many seconds before accepting
# new input again. Default is 0.12
  
  ROTATE_SENSITIVITY = 0.17
# When rotating the piece left or right, it waits as many seconds before 
# accepting new input again. Default is 0.17.
   
  FALL_SENSITIVITY = 0.03
# When dropping the piece down, it waits as many seconds before accepting
# new input again. Default is 0.03.
  
  ROW_DELETION_SPEED = 0.08
# The time between row deletion and next event (which could be another row
# deletion). Default is 0.08.

# ===========================================================================
#                          VISUAL OPTIONS
# ===========================================================================

# Each Piece on Tetris has own color. The empty space in the field also have 
# own color. The background behind the field also have color.
# Here you can set the values for all those colors.
# Valid values are between 0 and 255

        
  COLORS ={
      0 => { # Empy space on the Tetris Field. Do not edit this line.
      
        #The script default is RGB value of metalic color.
        "Red" => 161,   #Red value in RGB color
        "Green" => 169, #Green value in RGB color
        "Blue" => 169,  #Blue value in RGB color
        "Alpha" => 255   #Alpa color's opacity
      },
  
      1 => { # O piece. Do not edit this line.
      
        #The script default is RGB value of yellow color.
        "Red" => 255,   #Red value in RGB color
        "Green" => 246, #Green value in RGB color
        "Blue" => 0,  #Blue value in RGB color
        "Alpha" => 255   #Alpa color's opacity
      },
  
      2 => { # L piece. Do not edit this line.
      
        #The script default is RGB value of orange color.
        "Red" => 237,   #Red value in RGB color
        "Green" => 135, #Green value in RGB color
        "Blue" => 45,  #Blue value in RGB color
        "Alpha" => 255   #Alpa color's opacity
      },
  
      3 => { # J piece. Do not edit this line.
      
        #The script default is RGB value of blue color.
        "Red" => 0,   #Red value in RGB color
        "Green" => 0, #Green value in RGB color
        "Blue" => 204,  #Blue value in RGB color
        "Alpha" => 255   #Alpa color's opacity
      },
  
      4 => { # I piece. Do not edit this line.
      
        #The script default is RGB value of teal color.
        "Red" => 0,   #Red value in RGB color
        "Green" => 128, #Green value in RGB color
        "Blue" => 128,  #Blue value in RGB color
        "Alpha" => 255   #Alpa color's opacity
      },

      5 => { # S piece. Do not edit this line.
      
        #The script default is RGB value of green color.
        "Red" => 102,   #Red value in RGB color
        "Green" => 255, #Green value in RGB color
        "Blue" => 0,  #Blue value in RGB color
        "Alpha" => 255   #Alpa color's opacity
      },
  
      6 => { # T piece. Do not edit this line.
      
        #The script default is RGB value of purple color.
        "Red" => 191,   #Red value in RGB color
        "Green" => 0, #Green value in RGB color
        "Blue" => 255,  #Blue value in RGB color
        "Alpha" => 255   #Alpa color's opacity
      },
  
      7 => { # Z piece. Do not edit this line.
      
        #The script default is RGB value of red color.
        "Red" => 255,   #Red value in RGB color
        "Green" => 8, #Green value in RGB color
        "Blue" => 0,  #Blue value in RGB color
        "Alpha" => 255   #Alpa color's opacity
      },
      
      8 => { # Background color. Do not edit this line.
      
        #The script default is RGB value of very dark blue color.
        "Red" => 0,   #Red value in RGB color
        "Green" => 0, #Green value in RGB color
        "Blue" => 30,  #Blue value in RGB color
        "Alpha" => 255   #Alpa color's opacity
      }
    }
    

# You can set the block size. That will alter the field size,
# and the window size too, as they are derivative of the block size and
# the blocks distance.

# Keep in mind the tetris field contains 10 blocks per row, 20 blocks
# per column, 200 blocks total. All the blocks must fit in the screen.
# Since tetris blocks are squares, the given size is both width and height.
 
  BLOCK_SIZE      = 19 #Default size     19 Pixels
  BLOCKS_DISTANCE = 1  #Default distance  1 Pixel

# Background can be color, or picture. If picture is not set, then will use color.
# If is set, then will not use the color. The color used will be color 8 from 
# COLORS hash. Regardless if picture is set, the color will be used behind the 
# tetris field, that could be seen as border color between squares, if blocks 
# have distance of at least one pixel.

# Write the full path of the picture,starting from game directory. 
# The file extention can be omited when writing the file name. 
# For working example, see the default value.

  BACKGROUND_PICTURE = "Graphics/Titles1/Tower2"
  #set to nil or false, if you are not going to use background picture.

# ===========================================================================
#                          AUDIO OPTIONS
# ===========================================================================

# You can set background music for each Tetris level, or set one global for all
# levels. If certain tetris level has no own music set, will look for the global.
# There is also intro music, that is played when Tetris Scene is opened, but
# the player didn't started new game yet. Plays after game over sequence too.
# If no own and no global, the game will not have background music. 
  
  BACKGROUND_MUSIC = {
    :global => { :file =>"Audio/BGM/Theme4",  :volume => 70, :pitch => 100},
     :intro => { :file =>"Audio/BGM/Theme5",  :volume => 70, :pitch => 100},
          1 => { :file =>"Audio/BGM/Battle1", :volume => 70, :pitch => 100},
          2 => { :file =>"Audio/BGM/Battle2", :volume => 70, :pitch => 100},
          3 => { :file =>"Audio/BGM/Battle3", :volume => 70, :pitch => 100},
          4 => { :file =>"Audio/BGM/Battle4", :volume => 70, :pitch => 100},
          5 => { :file =>"Audio/BGM/Battle5", :volume => 70, :pitch => 100},
          6 => { :file =>"Audio/BGM/Battle6", :volume => 70, :pitch => 100},
          7 => { :file =>"Audio/BGM/Battle7", :volume => 70, :pitch => 100},
          8 => { :file =>"Audio/BGM/Battle8", :volume => 70, :pitch => 100},
          9 => { :file =>"Audio/BGM/Battle9", :volume => 70, :pitch => 100},
     
    
  }
# If you want certain (or all) levels to not have own background music, then
# comment the line for each level you don't want to have own background music.
# You can comment line by adding "#" symbol infront of line, just as i do
# here. The text would turn green.
# For the level you want to have own background music, you have to specify
# the filename, volume and pitch. Also, you need to specify background fideout
# time when the Tetris changes the background music.

  BGM_MUSIC_FADE_OUT = 2000  #in miliseconds  
# The built-in audio fadeout method works in miliseconds, not frames.
# There are 1000 miliseconds in one second.
  
  SOUNDS = {
    #Entry 1 -> Move Sound
    1 => { :file =>'Audio/SE/Cursor2',   :volume => 100, :pitch => 100},
    #Entry 2 -> Rotate Sound
    2 => { :file =>'Audio/SE/Cursor2',   :volume => 100, :pitch => 100},
    #Entry 3 -> Clash Sound
    3 => { :file =>'Audio/SE/Knock',     :volume => 100, :pitch => 100},
    #Entry 4 -> Delete Line Sound
    4 => { :file =>'Audio/SE/Decision2', :volume => 100, :pitch => 100},
    #Entry 5 -> Pause Game Sound
    5 => { :file =>'Audio/SE/Decision1', :volume => 100, :pitch => 100},
    #Entry 6 -> Unpause Sound
    6 => { :file =>'Audio/SE/Decision1', :volume => 100, :pitch => 100},
   }
# Edit the sound effect files according your preference.
# You can comment the lines, that contain sound effect for events you don't 
# want to have sound effect.
  
  GAME_OVER = { :file =>'Audio/ME/Gameover1', :volume => 100, :pitch => 100  }
# Music that will play for game over. For the example I set the default RPG
# gameover music, but I do not really find it fitting. If you don't want
# game over ME, then comment the entire line.
  
# ===========================================================================
#                                CONTROLS
# ===========================================================================  
  
# Here you can redefine the user controls during the tetris minigame.
# The usable control letters are:
# UP | DOWN | LEFT | RIGHT | A | B | C | X | Y | Z | L | R |
# SHIFT | CTRL | ALT | F5 | F6 | F7 | F8 | F9 |
# Each symbol is coresponding to keyboard key or gamepad key according
# the client settings.
  CONTROLS = {
    :move_left     => :LEFT,  #LEFT button used to move left.  
    :move_right    => :RIGHT, #RIGHT button used to move right.
    :drop          => :DOWN,  #DOWN button used to drop faster.
    :cw_rotate     => :UP,    #UP buton used to rotate clockwise.
    :cw_rotate_alt => :L,     #L button used alternatively to rotate clockwise.
    :ccw_rotate    => :R,     #R button used to rotate counter clockwise.
    :pause         => :B      #B button used to pause the game. 
  }

# Prob with control display is, that RPG maker does not give means to check
# which keyboard key was pressed, but rather it's symbol, which any owner of
# RPG maker game can change in F1 options. If he/she do that, the control display
# shown bellow will not anymore show correct info.
# Instead keyboard keys, you could type their symbols, but then,
# most users would have no idea which are those buttons.
# I still use keyboard controls in the default display, but I am not sure it 
# is very wise. 
# On side not, the arrow keys, the F keys, SHIFT, CTR, ALT, are always the same.

# I leave the decision to you what text to display, which is why I allow here in 
# options to change the entire strings, that are used for control display.
# Do not add another entry, do not modify the entry number, only entry asociated
# value (the text string).
# If you want entry line to be empty, make it empty string - "".
  DISPLAY_CONTROLS = {
      0 => "Controls:",
      1 => " Esc: Pause",
      2 => "←→: Move",
      3 => "  ↓: Fast Descend",
      4 => "↑ Q: Rotate Clockwise",
      5 => "   W: Reverse Rotate",
 } 
#  Default strings are not lined well together here, 
#  but are lined in the game. Go figure.
 
# ===========================================================================
#                           DESIGN SETTINGS
# =========================================================================== 

# Since the design at whole is matter of personal taste, I want to give the game
# developers the ability to redesign the scene objects ( the different windows),
# even if they have not real programing knowledge.
# Which is why here I will give every single window starting x and y coordinate,
# their transparency setting, their height and width, also and font sizes,
# so you can modify those values. Keep in mind, editing anything here have the 
# potential to make the game unplayable. Always keep somewhere the original 
# values of this header, in case you need to restore.

# Short letters I gonna use are:
# X  - starting x (horizontal) coordinate.
# Y  - starting y (vertical) coordinate.
# T  - Transparency.
# W  - Width
# H  - Height
# FS - Font Size
# LD - Line Distance - the distance between text lines in pixels.

# Tetris Field window comes first.
# That is the window where the game happens. Tetrominoes are spawned, moved
# and cleared. This window will have only x, y and transparency settings.
# Height and Width are derivatives of the block's size, which you can modify
# in the settings above.

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Whatever changes you make, keep the ',' symbol at the end of every line,
# or the game will crash(unless is last entry, but better just not touch).
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  TETRIS_FIELD = {
    :X => Graphics.width/8,
#   Default value uses formula, but you can always just write literal digit.
#   For example: :X => 68,
#   Write any value, that works for you.
#   Bellow there are more windows with formulae in values, which you can replace
#   on same manner.
    :Y => 5,
    :T => 255, # Fully visible by default
  }
  
# Window Block 1 comes second.
# That window displays the next tetromino figure, which is going to be spawned,
# and bellow it displays various stats data: hardship level, player action,
# scores, best scores. 
# You can change the window X, Y, height and width,  transparency, also and
# the font size for the stats data.
  WINDOW_BLOCK_1 = {
    :X  => TETRIS_FIELD[:X] + ( BLOCK_SIZE + BLOCKS_DISTANCE ) * 11,
    :Y  => 5,
    :W  => 215,
    :H  => 210,
    :T  => 255,
    :FS => 20,
    :LD => 17,
  }
  
# Window Pause is the third.
# During playing tetris, it stays inactive, but activates as soon the 
# player pauses the game, or bit after the player reaches game over. 
# Allowes starting new game, resuming game, or exit Tetris Scene.
  
  WINDOW_PAUSE = {
    :X  => WINDOW_BLOCK_1[:X],
    :Y  => WINDOW_BLOCK_1[:Y] + WINDOW_BLOCK_1[:H],
    :W  => WINDOW_BLOCK_1[:W],
    :H  => 64,
    :T  => 255,
    :FS => 20,
  }
  
# Window Block 2 comes last. That is the window, which is used to display
# the controls during game, and the game over message during game over.
# This window will have three different font sizes, for the different 
# text messages.
  
  WINDOW_BLOCK_2 = {
    :X    => WINDOW_BLOCK_1[:X],
    :Y    => WINDOW_PAUSE[:Y] + WINDOW_PAUSE[:H],
    :W    => WINDOW_BLOCK_1[:W],
    :H    => Graphics.height - (WINDOW_PAUSE[:Y] + WINDOW_PAUSE[:H] + 5),
    :T    => 255,
    :FS_1 => 20, # Used for controls text.
    :FS_2 => 28, # Used for "Game Over" string.
    :FS_3 => 20, # Used for the new best scores notification.
    :LD   => 17,
  }
  
# ===========================================================================
#                       TETRIS VOCAB DATA
# ===========================================================================

# Here will be defined all the text strings involved with this tetris script,
# excluding the ones about controls. Them you can redefine in the CONTROLS 
# header.

 VOCAB = {
   :new_game          => "New Game",
   :resume            => "Resume Game",
   :exit_scene        => "Exit",
   :next_tetro        => "Next",
   :level             => "Level",
   :actions           => "Actions",
   :cleared_lines     => "Cleared Lines",
   :scores            => "Scores",
   :best_scores       => "Best Scores",
   :timer             => "Time Spent",
   :game_over         => "Game Over",
   :new_high_scores1  => "Congratulations!!",
   :new_high_scores2  => "You set new high scores!",
   :play_tetris       => "Play Tetris", #This one appears in the main menu.
   :added_symbol      => ": "# adds : and space after certain strings
 }

# ===========================================================================
#                     MEANS TO EXTRACT TETRIS DATA
# ===========================================================================

# Extracting data can be useful, if you want for some reason, to use it
# outside the Tetris minigame.

# To extract the scores of the last played game(the one the user played before
# leaving the tetris scene), you can write this:
#   tetris_data = GGZiron_Tetris
#   $game_variables[1] = tetris_data.scores
   
#   First line is just to make link to my module.
#   Of course, you could use my module directly instead:
#   $game_variables[1] = GGZiron_Tetris.scores
   
#   Second line sets to Variable 1 from the event editor the value of
#   the scores from the last played game.
   
# Extracting best_scores is quite similar:
#   tetris_data = GGZiron_Tetris
#   $game_variables[2] = tetris_data.best_scores
   
# Extracting total time spent in frames (if you need it for some reason):
# !!!Need to note here: the timer doesn't work during game over sequence or 
# when the tetris is paused.
#   tetris_data = GGZiron_Tetris
#   $game_variables[3] = tetris_data.total_frames

# Extracting the game timer as text string, which could be used to display it 
# somewhere
#   tetris_data = GGZiron_Tetris
#   $game_variables[4] = tetris_data.timer_to_string
#   !Not sure if good idea to store strings to Game Variables, but can be done.
 
# Extracting the total time spent in seconds. To get the seconds, I divide
# the total frames on the game frame rate. If game lags, the timer would work
# slower than the timer on your system clock or any other watch.
#   tetris_data = GGZiron_Tetris
#   $game_variables[5] = tetris_data.total_seconds

# Extracting the timer display seconds. Means it counts only the seconds
# that passed after the last counted minute.
#   tetris_data = GGZiron_Tetris
#   $game_variables[6] = tetris_data.timer_seconds

# Extracting the total time spent in minutes. 
#   tetris_data = GGZiron_Tetris
#   $game_variables[7] = tetris_data.total_minutes

# Extracting the timer display minutes. Means it counts only the minutes
# that passed after the last counted hour.
#   tetris_data = GGZiron_Tetris
#   $game_variables[8] = tetris_data.timer_minutes

# Extracting the total hours played. Spending 0:59:59 still returns 0 hours.
#   tetris_data = GGZiron_Tetris
#   $game_variables[9] = tetris_data.hours_spent
  
# Extracting player's number of action only for the last game:
#   tetris_data = GGZiron_Tetris
#   $game_variables[10] = tetris_data.actions
#  Counts only succeseful moves.
#  It doen't count the fast drop.
  
#  Extracting player's total number of actions:
#  tetris_data = GGZiron_Tetris:
#  game_variable[11] = tetris_data.total_actions

# ===========================================================================
#                       END OF SETTINGS!!!!
# ===========================================================================

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Don't edit anything bellow this point, unless you know what you are doing!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  @best_scores              ||= 0 
  @last_game_scores         ||= 0 
  @total_actions            ||= 0 
  @total_deleted_lines      ||= 0 
  @total_frames             ||= 0
  @next_input_reaction_clock  = 0
  @pause                      = true
  
  class << self
    attr_accessor :window_info,         :clock,            :menu_tetris_enabled
    attr_accessor :clock_set_bgm,       :pause,            :next_input_reaction_clock
    attr_accessor :menu_tetris_display, :next_event
    
    attr_reader   :best_scores,         :last_game_scores, :total_deleted_lines
    attr_reader   :scores,              :deleted_lines,    :level 
    attr_reader   :total_frames,        :actions,          :total_actions
    attr_reader   :best_scores,         :speed
    
    def start_game
      @scores, @deleted_lines, @level, @pause         = 0, 0, 1, true
      @clock, @next_event, @next_input_reaction_clock = 0, Graphics.frame_rate, 0
      @bgm_pos, @actions, @new_record                 = 0, 0, false
      set_speed
      @window_info.draw_stats if @window_info
    end
      
    def generate_color(values)
      Color.new(values["Red"], values["Green"], values["Blue"], values["Alpha"])
    end 
    
    def new_record?
      @new_record
    end  
    
    def add_action(value = 1)
      @actions += value
      @total_actions += value
      window_info.update_actions
    end  
      
    def play_bgm( position = 0)
      file   = BACKGROUND_MUSIC[@level]
      file ||= BACKGROUND_MUSIC[:global]
      Audio.bgm_play_ggz25667(file[:file], file[:volume], file[:pitch], position) if file
      @clock_set_bgm = -1
    end
    
    def play_sound(sound_id)
      sound = SOUNDS[sound_id]
      Audio.se_play(sound[:file], sound[:volume], sound[:volume]) if sound
    end  
    
    def play_gameover_me
      me = GAME_OVER; Audio.me_play(me[:file], me[:volume], me[:volume]) if me
    end  
    
    def set_pause
      @pause = true
      @bgm_pos  = Audio.bgm_pos
      Audio.bgm_stop_ggz25667
    end
    
    def unset_pause
      @pause = false
      play_bgm(@bgm_pos) 
    end  
    
    def fade_bgm
      Audio.bgm_fade_ggz25667(BGM_MUSIC_FADE_OUT)
      @clock_set_bgm = @clock + (BGM_MUSIC_FADE_OUT/1000.0) * Graphics.frame_rate * 1.5
    end
    
    def scores=(value)
      @scores = value
      @new_record = true if @best_scores < @scores && !@new_record
      if @best_scores < @scores
         @best_scores = @scores 
         window_info.update_best_scores
      end
      window_info.update_scores 
    end
      
    def end_game
      set_last_game_scores
      @total_frames += @clock
      @clock = 0
    end  
    
    def exit_scene
      end_game
      @window_info = nil
    end  
      
    def base_fall_speed
      Graphics.frame_rate * BASE_FALL_SPEED
    end  
        
    def set_speed
      @speed = base_fall_speed/@level 
    end  
      
    def set_last_game_scores
      @last_game_scores = scores
    end
      
    def delete_line
      @deleted_lines += 1
      @total_deleted_lines += 1
      add_level if (@deleted_lines % LINES_PER_LEVEL == 0 && @level < 9)
      window_info.update_cleared_lines
    end  
      
    def add_level
      @level += 1
      set_speed
      window_info.update_level
      change_bgm
    end 
    
    def change_bgm
      name      = BACKGROUND_MUSIC[:global][:file]
      prev_name = BACKGROUND_MUSIC[:global][:file]
      name      = BACKGROUND_MUSIC[@level][:file]     if BACKGROUND_MUSIC[@level]
      prev_name = BACKGROUND_MUSIC[@level - 1][:file] if BACKGROUND_MUSIC[@level - 1] 
      fade_bgm                                        if name != prev_name
    end  
      
    def refresh_stats
      @window_info.draw_stats
    end 
       
    def deleted_lines_reward(deleted_lines)
      reward = 100 * @level
      case deleted_lines
        when 2; reward *= 3
        when 3; reward *= 5
        when 4; reward *= 8  
      end
      self.scores += reward
    end  
    
    def extract_save_data(contents)
      @best_scores         = contents[:ggzt42_best_scores]
      @last_game_scores    = contents[:ggzt42_last_game_scores]
      @total_actions       = contents[:ggzt42_total_actions]
      @total_deleted_lines = contents[:ggzt42_total_deleted_lines]
      @total_frames        = contents[:ggzt42_total_frames]
    end
    
    def total_seconds
      # returns all seconds spent
       @clock ||= 0 
      (@total_frames + @clock) / Graphics.frame_rate
    end  
  
    def timer_seconds; total_seconds % 60; end
    #return only the seconds passed after the last counted minute
      
    def total_minutes; total_seconds / 60; end
    #returns all seconds minutes
      
    def timer_minutes; total_minutes % 60; end 
    #return only the minutes passed after the last counted hour
      
    def hours_spent;   total_minutes / 60; end
    #returns the total hours, spent on the tetris.
      
    def timer_to_string
      #returns a timer as string
      seconds = timer_seconds;
      str_sec = seconds.to_s
      str_sec = "0" + str_sec if seconds < 10
      minutes = timer_minutes;
      str_min = minutes.to_s
      str_min = "0" + str_min if minutes < 10
      "#{hours_spent.to_s}:#{str_min}:#{str_sec}"
    end  
      
  end  #class << self
  
  class Tetris_Field
    
    attr_reader :tetromino, :viewport
    
    def initialize(x, y, rows, columns, z)
      @rows = rows
      @columns = columns
      w =  columns * block_size
      h =  rows * block_size
      create_viewport(x, y, w, h, z)
      tetris_bitmap
    end  
    
    def make_field_image
      create_viewport
      tetris_bitmap
    end  
    
    def take_row(row_index = 0)
      row = Array.new
      for i in 0...@columns do row << @field[i][row_index]; end  
      row
    end  
    
    def create_field_background(w, h)
      @field_background = Sprite.new(@viewport)
      @field_background.bitmap = Bitmap.new(w, h)
      color = GGZiron_Tetris.generate_color(GGZiron_Tetris::COLORS[8])
      @field_background.bitmap.fill_rect( @field_background.bitmap.rect, color)
    end  
    
    def create_viewport(x, y, w, h, z)
      @viewport = Viewport.new(x, y, w, h)
      @viewport.z = z
      create_field_background(w, h)
    end  
    
    def block_size
      GGZiron_Tetris::BLOCK_SIZE + GGZiron_Tetris::BLOCKS_DISTANCE 
    end  
    
    def tetris_bitmap
      @field = Array.new
      for x in 0...@columns do  #x may represent row, but is column walker
        @field << Array.new
        for y in 0...@rows do  #y represent column, but is row walker
          @field[x] << Building_Block.new(@viewport)
          @field[x][y].x = x
          @field[x][y].y = y
       end 
      end
      Graphics.update
    end
    
    def clear_field
      for x in 0...@columns do 
        for y in 0...@rows do
          @field[x][y].value = 0;
          @field[x][y].on_fall = false
        end
      end  
    end  
    
    def clear_tetromino
      @tetromino.clear_tetromino
    end  
    
    def display_tetromino(tetromino_id = 0)
      clear_tetromino if @tetromino
      return  if tetromino_id == 0
      @tetromino = Tetromino_Base.new(@field, tetromino_id )
      @tetromino.spawn
    end 
    
    def delete_field
      for x in 0...@columns do
        for y in 0...@rows do
          @field[x][y].dispose
        end  
      end
      @field_background.dispose
      @field = nil
    end  
    
    def show_hide_field(value = true)
      @viewport.visible = value
    end  
    
  end #Tetris_Field
  
  class Scene_Tetris < Scene_Base
  
    def start
      set_internal_clock
      Audio.bgm_stop_ggz25667
      Audio.bgs_stop_ggz25667
      create_background
      prep_new_game
      create_block_1_window
      create_tetris_window
      create_pause_window
      create_block_2_window
    end
    
    def set_internal_clock
      @internal_clock = Graphics.frame_rate
    end
  
    def start_tetris
      @internal_clock = -1
      Audio.me_stop
      Audio.bgm_stop_ggz25667
      @window_block_2.draw_control_contents 
      after_game_over if game_over?
      @window_block_1.define_next_spawn
      @pause_window.unselect
      @pause_window.deactivate
      @tetris_window.activate
      GGZiron_Tetris.play_sound(6)
      GGZiron_Tetris.unset_pause
      @pause_window.set_commands(GGZiron_Tetris::VOCAB[:resume])
    end
  
    def pause_tetris(play_sound = true)
      GGZiron_Tetris.play_sound(5) if play_sound
      GGZiron_Tetris.set_pause
      @tetris_window.deactivate
      @pause_window.activate
      @pause_window.select(0)
    end 
  
    def play_gameover
      GGZiron_Tetris.play_gameover_me
    end  
  
    def create_pause_window
      @pause_window = Window_Pause.new
      @pause_window.set_handler(:start_tetris, method(:start_tetris))
      @pause_window.set_handler(:exit, method(:return_scene))
    end  
  
    def create_background
      @background = Sprite.new
      if picture
        @background.bitmap = Bitmap.new(picture)
      else
        @background.bitmap = Bitmap.new(Graphics.width, Graphics.height)
        color = GGZiron_Tetris.generate_color(GGZiron_Tetris::COLORS[8])
        @background.bitmap.fill_rect( @background.bitmap.rect, color)
      end
    end  
	
    def create_tetris_window
      @tetris_window = Window_TetrisField.new(@window_block_1)
      @tetris_window.set_handler(:paused, method(:pause_tetris))
    end
	
    def create_block_1_window
      @window_block_1 = Window_Block1.new
      GGZiron_Tetris.window_info = @window_block_1
    end
	
    def create_block_2_window
      @window_block_2 = Window_Block2.new
      @window_block_2.set_handler( method(:game_over2) )
    end  
  
    def play_intro_bgm
      @internal_clock = -1
      file   = BACKGROUND_MUSIC[:intro]
      Audio.bgm_play_ggz25667(file[:file], file[:volume], file[:pitch]) if file
    end
 
    def game_over?
      return false if !@tetris_window
      return true if   @tetris_window.tetromino \
                    && @tetris_window.tetromino.game_over_flag
      false
    end
  
    def after_game_over
      @tetris_window.clear_field
      prep_new_game
    end  

    def game_over1
      GGZiron_Tetris.set_pause
      play_gameover
      @tetris_window.deactivate
      @window_block_1.handle_game_over
      @window_block_2.clock = 0
    end  
  
    def game_over2
      @pause_window.set_commands
      pause_tetris(false)
      GGZiron_Tetris.end_game
      set_internal_clock
    end  

    def refresh
      if @window_block_2.working?; @window_block_2.refresh; return; end  
      @tetris_window.refresh
      @internal_clock -= 1 if @internal_clock > 0
      play_intro_bgm if @internal_clock == 0
      if update_timer?; @window_block_1.update_timer; update_timer; end 
      game_over1 if !GGZiron_Tetris.pause && game_over?
    end 
  
    def return_scene
      GGZiron_Tetris.exit_scene
   	  @tetris_window.field.delete_field
      @tetris_window.field.viewport.dispose
      @window_block_1.field.delete_field
      @window_block_1.field.viewport.dispose
      @background.dispose
	  Audio.bgm_stop_ggz25667
      super
      Audio.start_prev_bgm_ggz25667
      Audio.start_prev_bgs_ggz25667
    end 
    
    def update_timer?
       @timer_seconds < GGZiron_Tetris.total_seconds
    end
     
    def update_timer
      @timer_seconds = GGZiron_Tetris.total_seconds
    end
    
    def prep_new_game 
      GGZiron_Tetris.start_game
      update_timer
    end  
  
    def dispose_main_viewport;                       end
    def dispose_background;                          end
    def update; super; refresh;                      end
    def picture; GGZiron_Tetris::BACKGROUND_PICTURE; end
  
  end #Scene_Tetris
  
  class Window_TetrisField < Window_Selectable
  
    attr_accessor :viewport
    attr_reader :tetromino, :field
  
    def initialize(tetris_next)
      x = GGZiron_Tetris::TETRIS_FIELD[:X]
      y = GGZiron_Tetris::TETRIS_FIELD[:Y]
      w = block_size * 10 + 10; h = block_size * 20 + 10
      super(x, y, w, h)
      self.opacity = GGZiron_Tetris::TETRIS_FIELD[:T]
      @tetris_next = tetris_next
      tetris_bitmap(x+5, y+5, 100)
      @deleted_rows = Array.new
      @erase_row_flag = -1
      @spawned = false
      @deleted_rows_at_once = 0
    end
      
    def block_size
      GGZiron_Tetris::BLOCK_SIZE + GGZiron_Tetris::BLOCKS_DISTANCE 
    end 
  
    def tetris_bitmap(x, y, z)
      @field = Tetris_Field.new( x, y, 20, 10, self.z)
      @rows  = Array.new
      for i in 0..19
        @rows << Tetris_Row.new(@field.take_row(i))
      end
    end  
  
    def refresh
      check_for_pause
      return if GGZiron_Tetris.pause
      self.clock += 1
      play_bgm if clock >= GGZiron_Tetris.clock_set_bgm && GGZiron_Tetris.clock_set_bgm >= 0
      make_move if @tetromino && @spawned && GGZiron_Tetris.next_input_reaction_clock <= clock
      if clock >= GGZiron_Tetris.next_event
        if @erase_row_flag >= 0
          field_check(@erase_row_flag)
          return
        end  
        @spawned ? fall : spawn 
      end 
    end 
  
    def check_for_pause
      return unless open? && active
      if Input.trigger?(:B)
        call_handler(:paused)
      end
    end  
  
    def clear_field
      @tetromino.deactivate if @tetromino
      @spawned = false
      @field.clear_field
    end  
  
    def next_input(value)
      GGZiron_Tetris.next_input_reaction_clock = clock + value
    end  
  
    def make_move
      controls = GGZiron_Tetris::CONTROLS
      return unless open? && active
      if Input.press?(controls[:move_left])
        @tetromino.move_left
        GGZiron_Tetris.play_sound(1)
        GGZiron_Tetris.add_action
        next_input(GGZiron_Tetris::MOVE_SENSITIVITY * Graphics.frame_rate)
      end  
    
      if Input.press?(controls[:move_right])
        @tetromino.move_right
        GGZiron_Tetris.play_sound(1)
        GGZiron_Tetris.add_action
        next_input(GGZiron_Tetris::MOVE_SENSITIVITY * Graphics.frame_rate)
      end  
    
      if Input.press?(controls[:cw_rotate]) || Input.press?(controls[:cw_rotate_alt])
        @tetromino.rotate_clockwise
        GGZiron_Tetris.play_sound(2)
        next_input(GGZiron_Tetris::ROTATE_SENSITIVITY * Graphics.frame_rate )
      end  
    
      if Input.press?(controls[:ccw_rotate])
        @tetromino.rotate_counter_clockwise
        GGZiron_Tetris.play_sound(2)
        next_input(GGZiron_Tetris::ROTATE_SENSITIVITY * Graphics.frame_rate )
      end  
    
      if Input.press?(controls[:drop])
        fall; next_input(GGZiron_Tetris::FALL_SENSITIVITY * Graphics.frame_rate)
      end  

    end  # make_move
  
    def spawn
      type = @tetris_next.field.tetromino.type
      @tetris_next.refresh_tetromino
      @tetromino = Tetromino.new(@rows, type)
      @tetromino.spawn
      @spawned = true
      set_next_event(GGZiron_Tetris::ROTATE_SENSITIVITY * Graphics.frame_rate)
    end  
  
    def fall
      if @tetromino.can_fall?
        @tetromino.fall
        set_next_event(GGZiron_Tetris.speed)
      else 
        @tetromino.deactivate
        @spawned = false
        set_next_event(GGZiron_Tetris.speed)
        field_check(19)
      end
    end 
  
    def set_next_event(value)
      GGZiron_Tetris.next_event = clock + value
    end  
  
    def field_check(lowest_y)
      for i in 0..lowest_y
        y = lowest_y - i
        if @rows[y].row_full? || @erase_row_flag.between?(0, 18)
          if y == 0
            @rows[y].delete_row
            @erase_row_flag = 19
            set_next_event(1)
            @deleted_rows_at_once += 1
            return
          else
            @rows[y].take_from(@rows[y-1])
            @erase_row_flag = y - 1
            set_next_event(1)
            return
          end
        end  
      end
      GGZiron_Tetris.deleted_lines_reward(@deleted_rows_at_once) if @deleted_rows_at_once > 0
      @deleted_rows_at_once = 0
      @erase_row_flag = -1
      set_next_event(GGZiron_Tetris::ROW_DELETION_SPEED * Graphics.frame_rate)
    end # field_check
    
    def play_bgm(position = 0); GGZiron_Tetris.play_bgm(position); end
    def clock;                  GGZiron_Tetris.clock;              end  
    def clock=(value);          GGZiron_Tetris.clock = value;      end 
  
  end  #Window_TetrisField
  
  class Window_Block1 < Window_Base
  
    attr_accessor :field
  
    def initialize
      x = GGZiron_Tetris::WINDOW_BLOCK_1[:X]
      y = GGZiron_Tetris::WINDOW_BLOCK_1[:Y]
      w = GGZiron_Tetris::WINDOW_BLOCK_1[:W]
      h = GGZiron_Tetris::WINDOW_BLOCK_1[:H]
      super(x, y, w, h)
      self.opacity = GGZiron_Tetris::WINDOW_BLOCK_1[:T]
      create_field
      create_spawning_bag
      draw_stats
    end  
  
    def create_field
      x = self.x + 10;    y = self.y + block_size/4 + 27
      w = self.width - block_size/2; h =  self.height - block_size/2 - 40
      @field = Tetris_Field.new(x, y, 3, 4, self.z)
    end  
    
    def handle_game_over
      clear_spawning_bag
      clear_tetromino
    end  
  
    def create_spawning_bag
      @spawning_bag = 0, 1, 2, 3, 4, 5, 6, 7
    end  
  
    def block_size
      GGZiron_Tetris::BLOCK_SIZE + GGZiron_Tetris::BLOCKS_DISTANCE 
    end  
  
    def random_number(max_value)
      rand(max_value)
    end 
    
    def clear_tetromino
      @field.clear_tetromino
    end  
 
    def refresh_tetromino
      clear_tetromino
      define_next_spawn
    end  
    
    def symb_add
       GGZiron_Tetris::VOCAB[:added_symbol]
    end  
	
	def initial_y
      block_size * 4
	end
	
	def line_distance
	  GGZiron_Tetris::WINDOW_BLOCK_1[:LD]
	end
	
    def update_level(init = true)
      vocab = GGZiron_Tetris::VOCAB[:level]
      str_1 = vocab + symb_add; str_2 = level
      width = text_size(str_1).width
      clwidth = text_size(str_2).width
      height = text_size(str_1).height
      contents.clear_rect(width, initial_y, width, height) 
      draw_text_ex(0, initial_y, str_1) if init
      draw_text_ex(width, initial_y, str_2)
    end  
    
    def update_actions(init = false)
      vocab = GGZiron_Tetris::VOCAB[:actions]
      str_1 = vocab + symb_add; str_2 = actions
      width = text_size(str_1).width
      clwidth = text_size(str_2).width
      height = text_size(str_1).height
      contents.clear_rect(width, initial_y + line_distance, clwidth, height) 
      draw_text_ex(0, initial_y + line_distance, str_1) if init
      draw_text_ex(width, initial_y + line_distance, str_2)
    end  
    
    def update_cleared_lines(init = false)
      vocab = GGZiron_Tetris::VOCAB[:cleared_lines]
      str_1 = vocab + symb_add; str_2 = deleted_lines
      width = text_size(str_1).width
      clwidth = text_size(str_2).width
      height = text_size(str_1).height
      contents.clear_rect(width, initial_y + line_distance * 2, clwidth, height)
      draw_text_ex(0, initial_y + line_distance * 2, str_1) if init
      draw_text_ex(width, initial_y + line_distance * 2, str_2)
    end  
    
    def update_scores(init = false)
      vocab = GGZiron_Tetris::VOCAB[:scores]
      str_1 = vocab + symb_add; str_2 = scores.to_s
      width = text_size(str_1).width
      clwidth = text_size(str_2).width
      height = text_size(str_1).height
      contents.clear_rect(width, initial_y + line_distance * 3, clwidth, height) 
      draw_text_ex(0, initial_y + line_distance * 3, str_1) if init
      contents.font.color = text_color(best_scores_color) if GGZiron_Tetris.new_record?
      width = text_size(str_1).width
      draw_text_ex(width, initial_y + line_distance * 3, str_2)
      contents.font.color = normal_color
    end  
    
    def update_best_scores(init = false)
      vocab = GGZiron_Tetris::VOCAB[:best_scores]
      str_1 = vocab + symb_add; str_2 = best_scores.to_s
      width = text_size(str_1).width
      clwidth = text_size(str_2).width
      height = text_size(str_1).height
      contents.clear_rect(width, initial_y + line_distance * 4, clwidth, height) 
      draw_text_ex(0, initial_y + line_distance * 4, str_1) if init
      contents.font.color = text_color(best_scores_color) if GGZiron_Tetris.new_record?
      width = text_size(str_1).width
      draw_text_ex(width, initial_y + line_distance * 4, str_2)
      contents.font.color = normal_color
    end  
    
    def update_timer(init = false)
      vocab = GGZiron_Tetris::VOCAB[:timer]
      str_1 = vocab + symb_add
      str_2 = GGZiron_Tetris.timer_to_string
      width = text_size(str_1).width
      clwidth = text_size(str_2).width
      height = text_size(str_1).height
      contents.clear_rect(width, initial_y + line_distance * 5, clwidth, height)
      draw_text_ex(0, initial_y + line_distance* 5, str_1) if init
      width = text_size(vocab + symb_add).width
      draw_text_ex(width, initial_y + line_distance * 5, str_2)
    end  
        
    def draw_stats
      contents.clear
      contents.font.size  = GGZiron_Tetris::WINDOW_BLOCK_1[:FS]
      vocab = GGZiron_Tetris::VOCAB
      contents.font.color = normal_color
      draw_text_ex(0, 0, vocab[:next_tetro] + vocab[:added_symbol])
      
      update_level(true);  update_actions(true);     update_cleared_lines(true)
      update_scores(true); update_best_scores(true); update_timer(true)
    end  
    
    def define_next_spawn
      create_spawning_bag if @spawning_bag.empty?
      item = random_number(@spawning_bag.size)
      type = @spawning_bag.delete_at(item)
      type = random_number(7) + 1 if type == 0
      @field.display_tetromino(type)
    end  
      
    def clear_spawning_bag; @spawning_bag = [];                    end
    def best_scores_color; GGZiron_Tetris::BEST_SCORES_TEXT_COLOR; end
    def reset_font_settings;                                       end
    def actions; GGZiron_Tetris.actions.to_s;                      end
    def level; GGZiron_Tetris.level.to_s;                          end
    def scores; GGZiron_Tetris.scores;                             end
    def best_scores; GGZiron_Tetris.best_scores;                   end
    def deleted_lines; GGZiron_Tetris.deleted_lines.to_s;          end
  
  end #Window_Block1 
  
  class Window_Pause < Window_Command 
    
    def initialize
      x = WINDOW_PAUSE[:X]; y = WINDOW_PAUSE[:Y]
      w = WINDOW_PAUSE[:W]; h = WINDOW_PAUSE[:H]
      super(w, h)
      self.x = x; self.y = y
      self.width = w; self.height = h
      self.opacity = GGZiron_Tetris::WINDOW_PAUSE[:T]
      contents.font.size = GGZiron_Tetris::WINDOW_PAUSE[:FS]
      set_commands
      select(0)
    end
    
    def set_commands(value = GGZiron_Tetris::VOCAB[:new_game])
      @start_resume = value
      refresh
    end  
  
    def make_command_list
      add_command(@start_resume, :start_tetris)
      add_command(GGZiron_Tetris::VOCAB[:exit_scene], :exit)
    end
    
    def refresh
      clear_command_list; make_command_list
      contents.clear;     draw_all_items
    end  
  
    def reset_font_settings; end
    def line_height; GGZiron_Tetris::WINDOW_PAUSE[:FS];     end

  
  end #Window_Pause
  
  class Window_Block2 < Window_Base
    
   attr_writer :clock
    
    def initialize
      x = GGZiron_Tetris::WINDOW_BLOCK_2[:X]
      y = GGZiron_Tetris::WINDOW_BLOCK_2[:Y]
      w = GGZiron_Tetris::WINDOW_BLOCK_2[:W] 
      h = GGZiron_Tetris::WINDOW_BLOCK_2[:H]
      super(x, y, w, h)
      self.opacity = GGZiron_Tetris::WINDOW_BLOCK_2[:T]
      @clock = -1 #internal timer, NOT the tetris timer
      draw_control_contents
    end
      
    def draw_control_contents
      clear_contents
      line_distance = GGZiron_Tetris::WINDOW_BLOCK_2[:LD]
      contents.font.size = GGZiron_Tetris::WINDOW_BLOCK_2[:FS_1]
      contents.font.color = normal_color
      text = GGZiron_Tetris::DISPLAY_CONTROLS
      x = ( self.width - text_size(text[0]).width) / 2 - standard_padding
      draw_text_ex(x, 0, text[0] )
      for i in 1..5 do draw_text_ex(0, line_distance * i, text[i] ); end  
    end  
    
    def game_over_contents
      clear_contents
      contents.font.size = GGZiron_Tetris::WINDOW_BLOCK_2[:FS_2]
      contents.font.color = normal_color
      game_over_str = GGZiron_Tetris::VOCAB[:game_over]
      x = ( self.width - text_size(game_over_str).width) / 2 - standard_padding
      draw_text_ex(x, 0, game_over_str )
    end
  
    def flash_contents
      return if @clock > GGZiron_Tetris::GAME_LOCK * Graphics.frame_rate
      game_over_contents if @clock % (Graphics.frame_rate/2) == 0
      contents.font.size = GGZiron_Tetris::WINDOW_BLOCK_2[:FS_3]
      contents.font.color = text_color(2) if GGZiron_Tetris.new_record?
      text =  GGZiron_Tetris::VOCAB[:new_high_scores1] + "\n"
      text += GGZiron_Tetris::VOCAB[:new_high_scores2]
      draw_text_ex(0, GGZiron_Tetris::WINDOW_BLOCK_2[:FS_2], text ) if flash_condition
    end 
   
    def flash_condition
      @clock % Graphics.frame_rate == 0 && GGZiron_Tetris.new_record?
    end  
           
    def refresh
      @clock += 1 if @clock >= 0
      call_handler if @clock > Graphics.frame_rate * GGZiron_Tetris::GAME_LOCK
      flash_contents
    end                                
          
    def clear_contents; contents.clear;                            end  
    def best_scores_color; GGZiron_Tetris::BEST_SCORES_TEXT_COLOR; end
    def working?; @clock >= 0;                                     end  
    def set_handler(method); @handler = method;                    end
    def call_handler; @clock =-1; @handler.call                    end
    def reset_font_settings;                                       end
    def actions; GGZiron_Tetris.actions.to_s;                      end    
    def level; GGZiron_Tetris.level.to_s;                          end 
    def scores; GGZiron_Tetris.scores;                             end
    def best_scores; GGZiron_Tetris.best_scores;                   end
    def deleted_lines; GGZiron_Tetris.deleted_lines.to_s;          end
  
  end #Window_Block2
  
  class Tetris_Row
    
    attr_reader :blocks
    
    def initialize(blocks)
      assign_row(blocks)
    end
    
    def assign_row(blocks)
      @blocks = blocks
    end  
    
    #checks if row is full.
    def row_full?
      for x in 0...@blocks.size do
        return false if @blocks[x].value == 0
      end 
      return true
    end  
    
    #takes the color values of other row
    def take_from(the_other_row)
      for x in 0...@blocks.size do
        @blocks[x].value = the_other_row.blocks[x].value
      end
    end 
    
    #deletes the color values within the row
    def delete_row 
      GGZiron_Tetris.play_sound(4)
      GGZiron_Tetris.delete_line
      for x in 0...@blocks.size do
        @blocks[x].value = 0
      end
    end  
      
  end #Tetris_Row
  
  class Tetromino_Base
    
    attr_reader :game_over_flag, :type
    
    def initialize(field,  type)
      @game_over_flag = false
      @field = field
      @tetromino_blocks = Array.new(4)
      @type = type
      @type = 1 + rand(7) if @type == 0
      @base ||= { :x =>1, :y=>2 }
      @base[:y] -= 1 if @type == 4
    end
    
    def spawn(spawning = true)
      @spawning = spawning
      case @type
        when 1; spawn_o; when 2; spawn_l
        when 3; spawn_j; when 4; spawn_i
        when 5; spawn_s; when 6; spawn_t;
        when 7; spawn_z;  
      end
      @spawning = false
    end 
    
    def block(x ,y)
      @field[x][y]
    end 
    
    def assign_block(index, x, y)
      @tetromino_blocks[index] = block(x, y)
      @game_over_flag = (!can_spawn?(x, y) && @spawning) || @game_over_flag
      @tetromino_blocks[index].value = @type
      @tetromino_blocks[index].on_fall = true
    end 
    
    def spawn_o
      assign_block(0, @base[:x],     @base[:y] - 1); 
      assign_block(1, @base[:x],     @base[:y]    );
      assign_block(2, @base[:x] + 1, @base[:y] - 1);
      assign_block(3, @base[:x] + 1, @base[:y]    );
    end
     
    def spawn_l(position = 1)
      assign_block(0, @base[:x] + 1, @base[:y] - 1); 
      assign_block(1, @base[:x] - 1, @base[:y]    );
      assign_block(2, @base[:x],     @base[:y]    );
      assign_block(3, @base[:x] + 1, @base[:y]    );
    end
    
    def spawn_j(position = 1)
      assign_block(0, @base[:x] - 1, @base[:y] - 1); 
      assign_block(1, @base[:x] - 1, @base[:y]    );
      assign_block(2, @base[:x],     @base[:y]    );
      assign_block(3, @base[:x] + 1, @base[:y]    );
    end
    
    def spawn_i(position = 1)
      assign_block(0, @base[:x] - 1, @base[:y]    ); 
      assign_block(1, @base[:x],     @base[:y]    );
      assign_block(2, @base[:x] + 1, @base[:y]    );
      assign_block(3, @base[:x] + 2, @base[:y]    );
    end
    
    def spawn_s(position = 1)
      assign_block(0, @base[:x],     @base[:y] - 1); 
      assign_block(1, @base[:x] + 1, @base[:y] - 1);
      assign_block(2, @base[:x] - 1, @base[:y]    );
      assign_block(3, @base[:x],     @base[:y]    );
    end
    
    def spawn_t(position = 1)
      assign_block(0, @base[:x],     @base[:y] - 1); 
      assign_block(1, @base[:x] - 1, @base[:y]    );
      assign_block(2, @base[:x],     @base[:y]    );
      assign_block(3, @base[:x] + 1, @base[:y]    );
    end
    
    def spawn_z(position = 1)
      assign_block(0, @base[:x] - 1, @base[:y] - 1); 
      assign_block(1, @base[:x],     @base[:y] - 1);
      assign_block(2, @base[:x],     @base[:y]    );
      assign_block(3, @base[:x] + 1, @base[:y]    );
    end
    
    def can_spawn?(x, y)
      !(block(x, y).value > 0)
    end  

    def clear_tetromino
      for i in 0..3 do
        @tetromino_blocks[i].value = 0; @tetromino_blocks[i].on_fall = false
      end  
    end
    
  end #Tetromino_Base
  
  class Tetromino < Tetromino_Base
    
    def initialize(rows, type)
      @rows = rows
      @base = { :x =>4, :y=>1 }
      super
    end
    
    def block(x, y)
      @rows[y].blocks[x]
    end 
    
    def move_left(tetromino = @tetromino_blocks)
      move(-1, 0, tetromino)
    end
    
    def move_right(tetromino = @tetromino_blocks)
      return move(1, 0, tetromino)
    end  
    
    def move_down(tetromino = @tetromino_blocks)
      return move(0, 1, tetromino)
    end  
    
    def move_up(tetromino = @tetromino_blocks)
      return move(0, -1, tetromino)
    end 
    
    def move(x_offset, y_offset, tetromino = @tetromino_blocks)
      return false unless can_move?(x_offset, y_offset, tetromino)
      @base[:x] += x_offset; @base[:y] += y_offset
      clear_tetromino
      for i in 0...tetromino.size do
        x = tetromino[i].x
        y = tetromino[i].y
        tetromino[i] = block(x + x_offset, y + y_offset)
        tetromino[i].value = @type
        tetromino[i].on_fall = true
      end
      true
    end  
    
    def assign_squares(new_shape)
      @tetromino_blocks = new_shape
      for i in 0..3 do
        @tetromino_blocks[i].value = @type
        @tetromino_blocks[i].on_fall = true 
      end  
      @tetromino_blocks.sort! {|a, b| b.y <=> a.y}
    end
    
    def can_move?(x_offset, y_offset, tetromino = @tetromino_blocks)
       tetromino.each do |iblock|
        return false if !(iblock.y + y_offset).between?(0, 19)
        return false if !(iblock.x + x_offset).between?(0, 9)
        next_block = block(iblock.x + x_offset, iblock.y + y_offset)
        return false if next_block.value > 0 && !next_block.on_fall
      end 
      true
    end
    
    def rotate(dir_multiplier, moved = false)
      return if @type == 1 #O piece doesn't rotate.
      new_shape = Array.new
      base_block = block(@base[:x], @base[:y])
      for i in 0..3 do
        #for loop --------------------------------------------------#
        x_offset = base_block.y - @tetromino_blocks[i].y
        y_offset = (@tetromino_blocks[i].x - base_block.x)  
        new_x = base_block.x + ( x_offset * dir_multiplier )
        new_y = base_block.y + ( y_offset * dir_multiplier )
        if (!new_x.between?(0, 9) || !new_y.between?(0, 19))
          if (new_x == (-1) || new_x == 10 || new_y == (-1))
            wall_kick(x_offset, y_offset, dir_multiplier, moved)
          end
          return
        end
        new_block = block(new_x, new_y)
        if (new_block.value > 0 && !new_block.on_fall)
          wall_kick(x_offset, 0, dir_multiplier, moved)
          return
        end 
        new_shape << new_block 
        #end loop---------------------------------------------------
      end
        clear_tetromino
        assign_squares(new_shape)
        GGZiron_Tetris.add_action if !moved
        true
    end
    
    def wall_kick(x_offset, y_offset, dir_multiplier, moved)
      return if moved
      base_x = @base[:x]; base_y = @base[:y]
      moved = true
      if x_offset != 0
        if move_left
          if rotate(dir_multiplier, moved); GGZiron_Tetris.add_action; return; end  
          move_right
        end  
        if move_right
          if rotate(dir_multiplier, moved); GGZiron_Tetris.add_action; return; end  
          move_left
        end 
      end  
      if y_offset != 0
        if move_down
          GGZiron_Tetris.add_action; rotate(dir_multiplier, moved)
        end  
      end  
    end  
     
    def deactivate
       @game_over_flag = false
       for i in 0..3 do
         @tetromino_blocks[i].on_fall = false 
       end
       GGZiron_Tetris.play_sound(3) if !@rows[19].row_full?
    end  
	
	  def rotate_clockwise; rotate(1);          end     
    def rotate_counter_clockwise; rotate(-1); end 
    def fall; move_down;                      end  
    def can_fall?; can_move?(0, 1);           end
    
  end #Tetromino
  
  class Building_Block
    
    attr_accessor :on_fall
    
    def value=(value)
      @value = value
      @value = 0 unless @value.between?(0 ,7)
      color = GGZiron_Tetris.generate_color(GGZiron_Tetris::COLORS[@value])
      @sprite.bitmap.fill_rect( @sprite.bitmap.rect, color)
    end  
    
    def initialize(viewport)
      @sprite = Sprite.new(viewport)
      @sprite.bitmap = Bitmap.new(block_size, block_size )
      @on_fall = false
      self.value = 0 
    end 
    
	def x; @x;                                                                     end
    def y; @y;                                                                     end
    def value; @value;                                                             end
    def dispose; @sprite.dispose;                                                  end 
    def block_size; GGZiron_Tetris::BLOCK_SIZE;                                    end  
    def block_distance; GGZiron_Tetris::BLOCKS_DISTANCE;                           end 
    def x=(value); @x = value; @sprite.x = value * ( block_size + block_distance); end 
    def y=(value); @y = value; @sprite.y = value * ( block_size + block_distance); end
	
  end  #Building_Block
  
end  #GGZiron_Tetris module

module DataManager
  
  class <<self
    alias_method :make_save_contents_oldggz424, :make_save_contents
    alias_method :extract_save_contents_oldggz424, :extract_save_contents
  end
  
  def self.make_save_contents(*args)
     contents = make_save_contents_oldggz424(*args)
     contents[:ggzt42_best_scores]         = GGZiron_Tetris.best_scores
     contents[:ggzt42_last_game_scores]    = GGZiron_Tetris.last_game_scores
     contents[:ggzt42_total_actions]       = GGZiron_Tetris.total_actions
     contents[:ggzt42_total_deleted_lines] = GGZiron_Tetris.total_deleted_lines
     contents[:ggzt42_total_frames ]       = GGZiron_Tetris.total_frames 
     contents
  end
   
  def self.extract_save_contents(*args)
    extract_save_contents_oldggz424(*args)
    GGZiron_Tetris.extract_save_data(args[0])
  end
  
end #DataManager

class Scene_Menu < Scene_MenuBase
  
  alias_method :create_comand_window_ggz54314, :create_command_window
  
  def create_command_window(*args)
    create_comand_window_ggz54314(*args)
    @command_window.set_handler(:tetris_ggz54314, method(:play_tetris_ggz54314))
  end
  
  def play_tetris_ggz54314
    SceneManager.call(GGZiron_Tetris::Scene_Tetris)
  end  
  
end  

class Window_MenuCommand < Window_Command
 
  alias_method :add_main_commands_ggz54314, :add_main_commands
  
  def add_main_commands(*args)
    add_main_commands_ggz54314(*args)
    str = GGZiron_Tetris::VOCAB[:play_tetris]
    add_command(str, :tetris_ggz54314, ggz54134_menu_tetris_enabled)\
                                if GGZiron_Tetris.menu_tetris_display
  end
  
  def ggz54134_menu_tetris_enabled
     GGZiron_Tetris.menu_tetris_enabled
  end
  
end  #Scene_Menu

module Audio
  
  class << self
    
    #ggz25667 part of names are so i avoid name clash
    alias_method :bgm_play_ggz25667, :bgm_play
    alias_method :bgm_stop_ggz25667, :bgm_stop
    alias_method :bgm_fade_ggz25667, :bgm_fade
    alias_method :bgs_play_ggz25667, :bgs_play
    alias_method :bgs_stop_ggz25667, :bgs_stop
    alias_method :bgs_fade_ggz25667, :bgs_fade
    
    def bgm_play(*args)
      @file_ggz25667 = args[0] 
      @volume_ggz25667 = (args[1]) ? args[1] : 100
      @pitch_ggz25667  = (args[2]) ? args[2] : 100
      bgm_play_ggz25667(*args)
    end 
  
    def bgm_stop 
      @file_ggz25667 = nil
      bgm_stop_ggz25667
    end 
    
    def bgm_fade(*args) 
      @file_ggz25667 = nil
      bgm_fade_ggz25667(*args)
    end
    
    def start_prev_bgm_ggz25667
      return if !@file_ggz25667
      @volume_ggz25667 ||= 100; @pitch_ggz25667 ||= 100
      bgm_play(@file_ggz25667, @volume_ggz25667, @pitch_ggz25667)
    end  
    
    def bgs_play(*args)
      @file_bgs_ggz25667 = args[0]
      @volume_bgs_ggz25667 = (args[1]) ?  args[1] : 100
      @pitch_bgs_ggz25667 = (args[2]) ? args[2] : 100
      bgs_play_ggz25667(*args)
    end 
  
    def bgs_stop 
      @file_bgs_ggz25667 = nil
      bgs_stop_ggz25667
    end 
    
    def bgs_fade(*args) 
      @file_bgs_ggz25667 = nil
      bgs_fade_ggz25667(*args)
    end
    
    def start_prev_bgs_ggz25667
      return if !@file_bgs_ggz25667
      @volume_bgs_ggz25667 ||= 100; @pitch_bgs_ggz25667 ||= 100
      bgs_play(@file_bgs_ggz25667,  @volume_bgs_ggz25667, @pitch_bgs_ggz25667)
    end 
    
  end  #class << self
  
end #Audio
# ===========================================================================
#                         END OF FILE
# =========================================================================== 
