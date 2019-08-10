($imported ||= {})[:GGZiron_Tetris] = true

module GGZiron_Tetris
  
=begin
                 About the Script:
 Author: GGZiron.
 Name: Tetris Mini Game
 Engine: RPG Maker VX ACE
 Version 1.2.1
 Terms of use: Free for comercial and non comercial project. * 
 Free to edit, but keep my part of the header, and don't claim the 
 script is yours. You have to credit me as GGZiron.
 
 This script is licensed under GNU General Public License v3.0
 To see more about it, check here:
 https://github.com/GGZiron/Tetris-Mini-Game/blob/master/LICENSE
 and here:
 https://www.gnu.org/licenses/gpl-3.0.html
 
 *All the terms listed above are only for the usage of this script. 
 The very Tetris is owned by "The Tetris Company". I do not know what 
 part of the Tetris is patented and what part is not, so you have to do 
 your research, if you are going to include my script in your project. 
 I suggest at very least, to not use the name "Tetris".
 
 With 1.2.0 version code, you cannot copy paste the entire settings header
 from previous version, and hope the code to work. It will not, as now
 it expect more entries from the options. So, copy paste existent entries
 from older version one by one instead.
 
 The idea to make tetris script came from Neo_Kum0rius_6000's script request 
 thread, although I started my tetris several months later. 
 
 If you see any bug, or have suggestion, you can post on this script thread on
 RPG Maker forum, found here:
 https://forums.rpgmakerweb.com/index.php?threads/tetris-mini-game.110592/
 ,or pm me. 
 Alternatively, you can report an issue here:
 https://github.com/GGZiron/Tetris-Mini-Game/issues
 
 For full Version History, including all changes between 1.0.0 and 1.1.0,
 open this: 
 https://github.com/GGZiron/Tetris-Mini-Game/blob/master/Version%20History
 
 Version History(partial):
 1.0.0: Initial Release on 02/07/2019.
 
 1.1.0 Released on 16/07/2019
   *New Option in the "General Options": Make your own tetromino spawning bags!
   *Improved a bit the code about text positioning in "Window Block 1", so
    changing font or block sizes would not ruin it.
   *Small code optimisations.
 1.1.1 Released on 21/07/2019
   *Now the field is one single sprite, and the building blocks are its
    rectangles. In previous versions each building block had its own sprite.
    That doesn't change the Tetris appearance.
   *Did more code optimisations.
 1.1.2 Released on 22/07/2019
   *Fixed a method, that was set to work with previous version objects,
    that would lead to game crash upon starting new game after game over.
 1.2.0 Released on 07/08/2019
   *Added option for setting max level.
   *Every window now have padding option
   *Option to set respawn speed and row deletion speed.
    In previous versions those two were one settings entry, executed by
    messy code.
   *Reorginized and reworked code, so now is more readible, and hopefully,
    more effective.
   *Renamed the menu button for playing Tetris, so it does not use the
    word "Tetris".

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
 
 Some additional information about my tetris:
 
 As clasical Tetris, it has 9* levels, and the last one is endless.
 Visually, it tries to look a little bit like clasic tetris with blocks.
 Once blocks are spawned upon, shaping a field, they never move, they only 
 change colors, forming tetromino figures, that looks like moving, rotating and 
 falling down with certain speed. All that is achieved via controlled recoloring.
 *With version 2.1.0, you can change how many levels the game to have.
 
 Default tetrominoes spawn order is as follows: There is virtual bag ( array )
 of all 7 pieces plus one fully random piece, which make bag of 8 pieces. 
 Those pieces will be spawned on random order. After each spawn, the spawning is 
 removed from the bag. Once the bag is empty, it will be reset.
 That means each piece type will be spawn at least once per every 8 spawned
 piece types, as one of them will be spawned twice. Also it means that
 a piece type is possible to be spawned 4 times in row. That can occure 
 if the given piece and the random piece are last 2 of their respective bag, 
 but first two of next bag, and the random piece happens to be the same as 
 other one.
 **With version 1.1.0, there is option you to set your spawning bags!
   Of course, you can always keep it as it is.
 
 The script provides music background(with settings about it), sound effects,
 certain data to be extracted via script calls upon main RPG game, if you
 want to reward or punish the player. Also it providers vocab settings, where
 you can change basically all the text strings that are coming from this script.
 Game visuals can be altered: each piece have color, set via rgb code, you
 can set also backgrounds color or background picture. You can alter window
 sizes, window positions, their opacity, font sizes in them and more.
 
 The entry bellow comes with my initial version, many stuffs are imrpoved since
 then:
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
  For bugs reports, I fix as soon as possible, if I manage to reproduce the
  error on my version.
 
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

  MAX_LEVEL = 9
# The max allowed level.
# The game speed formula relly on current level, so be carefull with
# the max level. Do not put negative or zero value, or you break the code.

  LINES_PER_LEVEL = 10
# How many lines the player must clear for hardship level to increase.
# Do not put negative or zero value, or you break the code.
   
  BEST_SCORES_TEXT_COLOR = 2
# Uses the colors set from Graphics/System/Window.png.
# The colors are in the bottom right corner of the png
# file, as each color have index, starting from 0. The default 
# value of 2 with default Window.png would produce orange text color.

  SPAWNING_BAGS = { #That option is introduced in version 1.1.0
    0 =>[0, 1, 2, 3, 4, 5, 6, 7], 
    #the "," after each entry is very important. Do not forget to put it.
#   Add more entries. 

#   Possible second and third entries:
#   1 =>[0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7],
#   2 =>[0], #Fully random.
#   You can also give symbol keys as shown bellow:
#   :favorite_tetroes => [1, 2, 3, 4],


  } #Do not delete this line, and do not add more entries bellow!!
  
# The Tetris will take randomly one of the entries, and will spawn tetromino
# based on every value given, and will delete that value, until the bag is empty.
# Once that happen, it will take another bag.
# When all bags are empty, the script will reset them.
# If you do not include a number within a spawning bag, the coresponding 
# tetromino wouldn't be spawned, unless:
#   You set zero or out of range values, then there is random chance to be 
#   spawned.
# If value of coresponding tetromino is not within the any bag, it won't be 
# spawned at all, unless:
#   You set zero or out of range values, then there is random chance to be 
#   spawned.

  @menu_tetris_enabled = true #Enables tetris play from menu, if true.
  @menu_tetris_display = true #Displays play tetris option in menu, if true.
# You can change the above two settings any time in game, with the
# following script calls:
# GGZiron_Tetris.menu_tetris_enabled = true or false
# GGZiron_Tetris.menu_tetris_display = true or false
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
 
# For game over music event, see the audio settings part of the settings.
 
# ===========================================================================
#                          TIME FLOW OPTIONS
# ===========================================================================

# The tetris speed flow tries not to depend on the frame rate of the game.
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
  
  ROW_DELETION_SPEED = 0.32
# The time between row deletion and next event (which could be another row
# deletion). Default is 0.32.

  TIME_FOR_RESPAWN = 0.13  #Default: 0.13
# The time needed for new Tetromino to appear, once the previous is landed.
# If line is cleared, the ROW_DELETION_SPEED will be added as many times, as
# many lines the player cleared. That option wasn't aviable before version
# 1.2.0, as before that this was handed with very messy code.


# ===========================================================================
#                          VISUAL OPTIONS
# ===========================================================================

# Each Piece on Tetris has own color. The empty space in the field also have 
# own color. The background behind the field also have color.
# Here you can set the values for all those colors.
# Valid values are between 0 and 255.
# Every "," symbol counts, do not eat any of them!!

        
  COLORS ={ #Do not add more entries here, is not supported.
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
      } #Do not touch.
    } #Do not touch. 
    

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

  BACKGROUND_PICTURE = "Graphics/Titles1/Tower2"
# Write the full path of the picture,starting from game directory. 
# The file extention can be omited when writing the file name. 
# For working example, see the default value.
# Set to nil or false, if you are not going to use background picture.

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
 #if there are move levels: add more entries here too:    

 
  }#do not touch this line, and do not add more BGM entries after
  
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
  
  SOUNDS = { #Do not add entries here, is not supported.
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
   }#do not touch this line
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
  CONTROLS = { #Do not add more entries, is not supported.
    :move_left     => :LEFT,  #LEFT button used to move left.  
    :move_right    => :RIGHT, #RIGHT button used to move right.
    :drop          => :DOWN,  #DOWN button used to drop faster.
    :cw_rotate     => :UP,    #UP buton used to rotate clockwise.
    :cw_rotate_alt => :L,     #L button used alternatively to rotate clockwise.
    :ccw_rotate    => :R,     #R button used to rotate counter clockwise.
    :pause         => :B      #B button used to pause the game. 
  }#Do not touch this line.

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
  #Possible to add more entries, but keep the key numbers patern.
  #Unlikely to fit more entries unless you shrink the text.
      0 => "Controls:",
      1 => " Esc: Pause",
      2 => "←→: Move",
      3 => "  ↓: Fast Descend",
      4 => "↑ Q: Rotate Clockwise",
      5 => "   W: Reverse Rotate",
 } #Do not touch.
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
# P  - Padding. Smallest distance between Window and visual objects inside.
#      When set to nil, will use standard padding.
#      Paddin comes with version 1.2.0

# Do not add entry letters to windows, where they are not present.
# If they are not present, then they are not supported there.

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
    :T => 255, #Fully visible by default
    :P => 0,   #Field will "touch" the default window botder.
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
    :P  => nil, #when nil, it will use standard_padding
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
    :P  => nil, #when nil, it will use standard_padding
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
    :P    => nil, #when nil, it will use standard_padding
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
   :play_tetris       => "Play Bricks", # This one appears in the main menu.
   :added_symbol      => ": "# adds : and space after certain strings
#                              Tip: You can turn added_symbol to empty string,
#                                   and add symbol manualy in the other strings.
 }#Do not touch this.

# ===========================================================================
#                     MEANS TO EXTRACT TETRIS DATA
# ===========================================================================

# Extracting data can be useful, if you want for some reason, to use it
# outside the Tetris minigame.

# To extract the scores of the last played game(the one the user played before
# leaving the tetris scene), you can write this:
#   tetris_data = GGZiron_Tetris
#   $game_variables[n] = tetris_data.scores
   
#   First line is just to make link to my module.
#   Of course, you could use my module directly instead:
#   $game_variables[n] = GGZiron_Tetris.scores
   
#   Second line sets to Variable n from the event editor the value of
#   the scores from the last played game. Instead n, use variable ID
#   according the your preference.
   
# Extracting best_scores is quite similar:
#   tetris_data = GGZiron_Tetris
#   $game_variables[n] = tetris_data.best_scores

# Extracting total deleted lines:
#   tetris_data = GGZiron_Tetris
#   $game_variables[n] = tetris_data.total_deleted_lines
   
# Extracting total time spent in frames (if you need it for some reason):
# when the tetris is paused.
#   tetris_data = GGZiron_Tetris
#   $game_variables[n] = tetris_data.total_frames

# Extracting the game timer as text string, which could be used to display it 
# somewhere
#   tetris_data = GGZiron_Tetris
#   $game_variables[n] = tetris_data.timer_to_string
#   !Not sure if good idea to store strings to Game Variables, but can be done.
 
# Extracting the total time spent in seconds. To get the seconds, I divide
# the total frames on the game frame rate. If game lags, the timer would work
# slower than the timer on your system clock or any other watch.
#   tetris_data = GGZiron_Tetris
#   $game_variables[n] = tetris_data.total_seconds

# Extracting the timer display seconds. Means it counts only the seconds
# that passed after the last counted minute.
#   tetris_data = GGZiron_Tetris
#   $game_variables[n] = tetris_data.timer_seconds

# Extracting the total time spent in minutes. 
#   tetris_data = GGZiron_Tetris
#   $game_variables[n] = tetris_data.total_minutes

# Extracting the timer display minutes. Means it counts only the minutes
# that passed after the last counted hour.
#   tetris_data = GGZiron_Tetris
#   $game_variables[n] = tetris_data.timer_minutes

# Extracting the total hours played. Spending 0:59:59 still returns 0 hours.
#   tetris_data = GGZiron_Tetris
#   $game_variables[n] = tetris_data.hours_spent
  
#  Extracting player's total number of actions:
#  tetris_data = GGZiron_Tetris:
#  $game_variables[n] = tetris_data.total_actions

# ===========================================================================
#                       END OF SETTINGS!!!!
# ===========================================================================

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Don't edit anything bellow this point, unless you know what you are doing!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  #script call support ▼
  class << self
    attr_accessor :menu_tetris_enabled,  :menu_tetris_display
    def total_deleted_lines; processor::total_deleted_lines end
    def best_scores;         processor::best_scores         end 
    def total_seconds;       processor::total_seconds       end  
    def timer_seconds;       processor::timer_seconds       end
    def total_minutes;       processor::total_minutes       end
    def timer_minutes;       processor::timer_minutes       end 
    def hours_spent;         processor::hours               end
    def timer_to_string;     processor::timer_to_string     end
    def actions;             processor::actions             end
    def scores;              processor::last_game_scores    end  
    def total_actions;       processor::total_actions       end
    def total_scores;        processor::total_scores        end
    def total_frames;        processor::total_frames        end 
    def processor;           Tetris_Process                 end
  end  #class << self
  
# ===========================================================================
#                     ▼ module Tetris Process
# =========================================================================== 
  module Tetris_Process
# Controlls most of the interactions between objects, manipulates Tetris data.   
    class << self
      
      attr_reader :level, :total_actions, :scores, :best_scores
      attr_reader :last_game_scores, :scores, :deleted_lines
      attr_reader :total_frames, :actions, :total_deleted_lines
      
#  ------------------------- Data_initialization ----------------------------
      
      def link_objects(w)
        @tetris_window = w[0]
        @window_block_1 = w[1]
        @window_block_2 = w[2]
        @window_block_2.set_handler(method(:game_over))
        @pause_window = w[3]
        create_field_links
        set_into_bgm_clock
      end
      
      def initialize_data
        @best_scores, @total_frames, @total_actions = 0, 0, 0
        @total_deleted_lines, @last_game_scores     = 0, 0
      end  
    
      def set_game #initializes some variables
        @next_input_reaction_clock, @scores = 0, 0
        @level, @bgm_pos                    = 1, 0
        @clock_set_bg, @actions             = 0, 0
        @clock_set_bgm, @deleted_lines      = 0, 0
        @pause, @new_record                 = true, false
        @spawned, @keys                     = false, Array.new
        @next_event                         = Graphics.frame_rate
        set_speed
      end
      
      def set_into_bgm_clock
        @into_bgm_clock = Graphics.frame_rate
      end
      
      def create_field_links
        @main_field = @tetris_window.field
        @next_field = @window_block_1.field
      end  
#  -------------------------- Starting Processes ---------------------------
     def start_game
        create_spawning_bag
        refresh_next_tetromino
        @into_bgm_clock = -1
        Audio.me_stop
        Audio.bgm_stop
        @window_block_2.draw_control_contents 
        after_game_over if game_over?
        @pause_window.unselect
        @pause_window.deactivate
        @tetris_window.activate
        play_sound(6)
        unset_pause
        @pause_window.set_commands(VOCAB[:resume])
      end 
#  --------------------------- Ending Processes -----------------------------   
      def end_game
        @last_game_scores = scores
      end  
    
      def exit_scene #frees data after scene end
        end_game
        @tetris_window, pause_window        = nil, nil
        @window_block_1, window_block_2     = nil, nil
        @next_input_reaction_clock, @scores = nil, nil
        @level, @bgm_pos                    = nil, nil
        @clock, @next_input_reaction_clock  = nil, nil
        @clock_set_bg, @actions             = nil, nil
        @clock_set_bgm, @deleted_lines      = nil, nil
        @pause, @new_record                 = nil, nil
        @next_event, @keys                  = nil, nil
        @bag_holder, @window_info           = nil, nil
        @new_record, @speed                 = nil, nil
        @action_made                        = nil
      end
#  ------------------------------- Getters ----------------------------------
      def base_fall_speed
        Graphics.frame_rate * BASE_FALL_SPEED
      end  
      
      def block_size_with_border
        BLOCK_SIZE + BLOCKS_DISTANCE 
      end
      
      def total_seconds #returns all seconds spent
        @total_frames / Graphics.frame_rate
      end  
  
      def timer_seconds; total_seconds % 60; end
      
      def total_minutes; total_seconds / 60; end
      
      def timer_minutes; total_minutes % 60; end 
      
      def hours;  total_minutes / 60; end
      
      def timer_to_string
        sprintf("%02d:%02d:%02d", hours, timer_minutes, timer_seconds)
      end  
      
      def generate_color(c)
        Color.new(c["Red"], c["Green"], c["Blue"], c["Alpha"])
      end 
    
      def random_number(max_value)
        rand(max_value)
      end 
      
      def get_next_spawn
        create_spawning_bag if @spawning_bag.empty?
        item = random_number(@spawning_bag.size)
        type = @spawning_bag.delete_at(item)
        type = random_number(7) + 1 if type == 0
        type
      end 
#  ------------------------------ Setters -----------------------------------
      def set_speed
        @speed = base_fall_speed/@level 
      end
      
      def set_next_event(value)
        @next_event = @total_frames + value
      end
      
      def set_pause
        @pause = true
        @bgm_pos = Audio.bgm_pos
        Audio.bgm_stop
      end
    
      def unset_pause
        @pause = false
        play_bgm(@bgm_pos)
      end
#  ----------------------------- Checkers ------------------------------------
      def new_record?
        @new_record
      end  
      
      def game_over?
        return false if !@main_field
        return true if   @main_field.tetromino && @main_field.tetromino.game_over_flag
        false
      end
#  ----------------------- Audio Processes ----------------------------------
      def on_change_bgm
        b = BACKGROUND_MUSIC
        name      = b[:global][:file]
        prev_name = b[:global][:file]
        name      = b[@level][:file]     if b[@level]
        prev_name = b[@level - 1][:file] if b[@level - 1] 
        fade_bgm                         if name != prev_name
      end  
    
      def play_bgm(position = 0)
        f   = BACKGROUND_MUSIC[@level]
        f ||= BACKGROUND_MUSIC[:global]
        Audio.bgm_play(f[:file], f[:volume], f[:pitch], position) if f
        @clock_set_bgm = -1
      end
      
      def fade_bgm
        Audio.bgm_fade(BGM_MUSIC_FADE_OUT)
        @clock_set_bgm = @total_frames + (BGM_MUSIC_FADE_OUT/1000.0) * Graphics.frame_rate * 1.5
      end
    
      def play_sound(sound_id)
        sound = SOUNDS[sound_id]
        Audio.se_play(sound[:file], sound[:volume], sound[:volume]) if sound
      end  
    
      def play_gameover_me
        me = GAME_OVER; 
        Audio.me_play(me[:file], me[:volume], me[:volume]) if me
      end  
      
      def play_intro_bgm
        file = BACKGROUND_MUSIC[:intro]
        Audio.bgm_play(file[:file], file[:volume], file[:pitch]) if file
      end
#  --------------------------- Data Processes -------------------------------
      def create_spawning_bag
        bags = SPAWNING_BAGS
        if bags.empty?
          @spawning_bag = 0, 1, 2, 3, 4, 5, 6, 7
        else
          bags.each_key{|key| @keys << key} if @keys.empty?
          key = @keys.delete_at(random_number(@keys.size))
          @spawning_bag = bags[key].dup
        end  
      end

      def add_level
        @level += 1
        set_speed
        @window_block_1.update_level
        on_change_bgm
      end 
      
      def add_action(value = 1)
        @actions += value
        @total_actions += value
        @window_block_1.update_actions
      end
      
      def deleted_lines_reward(deleted_lines)
        reward = 100 * @level
        reward *= case deleted_lines
          when 2; 3; when 3; 5 ;when 4; 8
          else; 1 #It shouldn't come here.  
        end
        self.scores = reward
      end  
    
      def scores=(value)
        @scores += value
        @new_record = true if @best_scores < @scores && !@new_record
        if @best_scores < @scores
          @best_scores = @scores 
          @window_block_1.update_best_scores
        end
        @window_block_1.update_scores 
      end
      
      def delete_line
        @deleted_lines += 1
        @total_deleted_lines += 1
        add_level if (@deleted_lines % LINES_PER_LEVEL == 0 && @level < MAX_LEVEL)
        @window_block_1.update_cleared_lines
      end    
#  --------------------------- Input Processes ------------------------------
      def make_move
        c = CONTROLS; i = Input
        move_left            if i.press?(c[:move_left])
        move_right           if i.press?(c[:move_right])
        rotate_clockwise     if i.press?(c[:cw_rotate]) ||
                                i.press?(c[:cw_rotate_alt])
        rotate_cclockwise    if i.press?(c[:ccw_rotate])
        drop                 if i.press?(c[:drop])
        @action_made = false
      end 
      
      def move_left
        if @main_field.tetromino.move_left
          action_success(MOVE_SENSITIVITY * Graphics.frame_rate, 2)
        end
      end  
      
      def move_right
        return if @action_made
        if @main_field.tetromino.move_right
          action_success(MOVE_SENSITIVITY * Graphics.frame_rate, 1)
        end
      end
      
      def rotate_clockwise
        return if @action_made
        if @main_field.tetromino.rotate_clockwise
          action_success(ROTATE_SENSITIVITY * Graphics.frame_rate, 2)
        end  
      end  
      
      def rotate_cclockwise
        return if @action_made
        if @main_field.tetromino.rotate_counter_clockwise
          action_success(ROTATE_SENSITIVITY * Graphics.frame_rate, 2)
        end  
      end  
      
      def drop
        unless @action_made
          drop_time = FALL_SENSITIVITY * Graphics.frame_rate
          next_input(drop_time)
        end  
        fall
      end  
      
      def action_success(n_i, sound)
        add_action; next_input(n_i) if n_i; play_sound(sound) if sound
        @action_made = true
      end  
      
      def next_input(value)
        @next_input_reaction_clock = @total_frames + value
      end  
#  -------------------------- Game Over Handling ----------------------------
     def prep_a_game_over
        @window_block_2.final_clock = GAME_LOCK * Graphics.frame_rate
        set_pause
        play_gameover_me
        @tetris_window.deactivate
        clear_next_tetromino
      end  
      
      def game_over
        @pause_window.set_commands
        pause_tetris(false)
        end_game
        set_into_bgm_clock
      end  

      def after_game_over
        @tetris_window.clear_field
        set_game
        refresh_stats
      end  
#  -------------------------- Objects Interaction ---------------------------
      def refresh_stats
        @window_block_1.draw_stats
      end
    
      def clear_next_tetromino
        @next_field.clear_tetromino
      end  
 
      def refresh_next_tetromino
        clear_next_tetromino
        type = get_next_spawn
        @next_field.display_tetromino(type)
      end  
      
      def fall
        tetro = @main_field.tetromino
        if tetro.can_fall?
          tetro.fall
          set_next_event(@speed)
        else 
          tetro.deactivate
          @spawned = false
          set_next_event(1)
          @fiber = Fiber.new do field_check end
          @fiber.resume
        end
      end 
      
      def check_for_pause_press
        if Input.trigger?(:B)
          pause_tetris
        end
      end  
      
      def pause_tetris(play_sound = true)
        play_sound(5) if play_sound
        set_pause
        @tetris_window.deactivate
        @pause_window.activate
        @pause_window.select(0)
      end 
      
      def field_check
        deleted_rows = 0
        while @main_field.lowest_full_row_index > -1 do
          @main_field.clear_line
          delete_line
          set_next_event(ROW_DELETION_SPEED * Graphics.frame_rate)
          play_sound(4)
          deleted_rows += 1
          Fiber.yield
        end
        play_sound(3) if deleted_rows == 0
        deleted_lines_reward(deleted_rows) if deleted_rows > 0
        set_next_event(TIME_FOR_RESPAWN * Graphics.frame_rate)
        @fiber = nil
      end 
        
      def spawn
        type = @next_field.tetromino.type
        @main_field.spawn(type)
        refresh_next_tetromino
        @spawned = true
        tetro = @main_field.tetromino
        speed = ROTATE_SENSITIVITY * Graphics.frame_rate
        set_next_event(tetro.game_over_flag ? 1 : @speed)
      end      
#  ----------------------------- The Heart ----------------------------------
      def tup_tup
        @total_frames += 1; 
        tf = @total_frames; nirc = @next_input_reaction_clock
        play_bgm  if tf >= @clock_set_bgm && @clock_set_bgm >= 0
        make_move if @main_field.tetromino && @spawned && nirc <= tf
        @fiber ? @fiber.resume : (@spawned ? fall : spawn ) if tf >= @next_event
      end  
      
      def update
        if @window_block_2.working?; @window_block_2.refresh; return end
        check_for_pause_press
        unless @pause
          if game_over?; prep_a_game_over; return; end
          tup_tup
          @window_block_1.timer_check
        else
          @into_bgm_clock -= 1 if @into_bgm_clock >= 0
          play_intro_bgm if @into_bgm_clock == 0
        end  
      end  
#  ------------------------- Save Data Handler ------------------------------      
      def extract_save_data(contents)
        @best_scores         = contents[:ggzt42_best_scores]
        @last_game_scores    = contents[:ggzt42_last_game_scores]
        @total_actions       = contents[:ggzt42_total_actions]
        @total_deleted_lines = contents[:ggzt42_total_deleted_lines]
        @total_frames        = contents[:ggzt42_total_frames]
        initialize_data        unless @total_actions && @last_game_scores   &&
                                      @total_frames  && total_deleted_lines &&
                                      @best_scores
      end 
    
      def make_save_contents(contents)
        contents[:ggzt42_best_scores]         = @best_scores
        contents[:ggzt42_last_game_scores]    = @last_game_scores
        contents[:ggzt42_total_actions]       = @total_actions
        contents[:ggzt42_total_deleted_lines] = @total_deleted_lines
        contents[:ggzt42_total_frames ]       = @total_frames
        contents
      end
  
    end #class self
    
  end #Tetrid_Process  
  
# ===========================================================================
#                    ▼ class Scene Tetris
# ===========================================================================
  
  class Scene_Tetris < Scene_Base
  
    def start
      sound_management
      create_background
      prep_new_game
      create_block_1_window
      create_tetris_window
      create_pause_window
      create_block_2_window
      link_processor
    end
    
    def sound_management
      Audio.bgm_stop; Audio.bgs_stop
      @saved_bgm = RPG::BGM.last
      @saved_bgs = RPG::BGS.last
    end  
  
    def start_tetris
      processor::start_game
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
        color = t_data.generate_color(t_data::COLORS[8])
        @background.bitmap.fill_rect( @background.bitmap.rect, color)
      end
    end  
	
    def create_tetris_window
      @tetris_window = Window_TetrisField.new
    end
	
    def create_block_1_window
      @window_block_1 = Window_Block1.new
    end
	
    def create_block_2_window
      @window_block_2 = Window_Block2.new
      
    end  
    
    def link_processor
      w = @tetris_window, @window_block_1, @window_block_2, @pause_window
      processor::link_objects(w)
    end   

    def update
      super
      return if @ggzt_exiting
      processor::update
    end 
  
    def return_scene
      @ggzt_exiting = true
      Graphics.freeze
      processor.exit_scene
   	  @tetris_window.field.delete_field
      @tetris_window.field.viewport.dispose
      @window_block_1.field.delete_field
      @window_block_1.field.viewport.dispose
      @background.bitmap.dispose
      @background.dispose
	    Audio.bgm_stop
      super
      @saved_bgm.replay if @saved_bgm
      @saved_bgs.replay if @saved_bgs
    end 
    
    def dispose_main_viewport;             end
    def prep_new_game; processor::set_game end
    def picture;       BACKGROUND_PICTURE  end
    def processor;     Tetris_Process      end  
    
  end #Scene_Tetris
    
# ===========================================================================
#                    ▼ class Tetris Field Base
# ===========================================================================
  
  class Tetris_Field_Base
    
    attr_reader :tetromino, :viewport, :rows
    
    def initialize(x, y, rows, columns, z)
      @rows_count = rows
      @columns_count = columns
      w =  columns * block_size
      h =  rows * block_size
      create_viewport(x, y, w, h, z)
      tetris_bitmap(w, h)
    end  
    
    def take_row(row_index = 0)
      row = Array.new
      for i in 0...@columns_count do row << @building_blocks[i][row_index]; end  
      row
    end  
    
    def create_field_background(w, h)
      @field_background = Sprite.new(@viewport)
      @field_background.bitmap = Bitmap.new(w, h)
      color = Tetris_Process::generate_color(COLORS[8])
      @field_background.bitmap.fill_rect( @field_background.bitmap.rect, color)
    end  
    
    def create_viewport(x, y, w, h, z)
      @viewport = Viewport.new(x, y, w, h)
      @viewport.z = z
      create_field_background(w, h)
    end  
    
    def block_size
      Tetris_Process::block_size_with_border
    end  
    
    def tetris_bitmap(w, h)
      @field = Sprite.new(@viewport)
      @field.bitmap = Bitmap.new(w, h)
      @building_blocks = Array.new
      @rows = Array.new
      for x in 0...@columns_count do #x may represent row, but is column walker
        @building_blocks[x] = Array.new
        for y in 0...@rows_count do  #y represent column, but is row walker
          @building_blocks[x] << Building_Block.new(@field, x, y)
        end 
      end
    end
        
    def move_all_rows(bottom_line)
      for i in 0..bottom_line
        y = bottom_line - i
        return @rows[y].delete_row if y == 0
        return unless @rows[y].any?
        @rows[y].take_from(@rows[y-1])
      end  
    end  
    
    def clear_tetromino
      @tetromino.clear_tetromino if @tetromino
    end  
    
    def display_tetromino(tetromino_id = 0)
      clear_tetromino if @tetromino
      return  if tetromino_id == 0
      @tetromino = Tetromino_Base.new(@building_blocks, tetromino_id )
      @tetromino.spawn
    end 
    
    def delete_field
      @field.bitmap.dispose; @field_background.bitmap.dispose
      @field.dispose;        @field_background.dispose
      @viewport.dispose
    end  
    
    def show_hide_field(value = true)
      @viewport.visible = value
    end  
    
  end #Tetris_Field_Base
  
# ===========================================================================
#                    ▼ class Tetris Field
# ===========================================================================
  
  class Tetris_Field < Tetris_Field_Base
    
    def initialize(x, y, rows, columns, z)
      super
      create_rows
    end  
    
    def clear_field
      @tetromino.deactivate if @tetromino
      for x in 0...@columns_count do 
        for y in 0...@rows_count do
          @building_blocks[x][y].value = 0
          @building_blocks[x][y].on_fall = false
        end
      end  
    end  
    
    def create_rows
      @rows = Array.new
      for y in 0...@rows_count do
        @rows << Tetris_Row.new(take_row(y))
      end
    end
    
    def spawn(type)
      @tetromino = Tetromino.new(@rows, type)
      @tetromino.spawn
    end
      
    def lowest_full_row_index # return -1 if none
      @rows.each_index do |index|
        y = (@rows.size - 1) - index
        return y if @rows[y].full?
      end
      return -1
    end
    
    def clear_line(clear_y = lowest_full_row_index)
      return if clear_y == -1
      return @rows[clear_y].delete_row if clear_y == 0
      move_all_rows(clear_y) 
    end
    
    def display_tetromino; end
    
  end #Tetrus_Field  
    
# ===========================================================================
#                    ▼ class Window Tetris Field
# ===========================================================================

  class Window_TetrisField < Window_Selectable
  
    attr_reader :field
  
    def initialize
      x = TETRIS_FIELD[:X]; y = TETRIS_FIELD[:Y]; p = TETRIS_FIELD[:P]
      p = standard_padding unless p
      border = 5
      w = (block_size * 10) + 2 * (p + border); h = (block_size * 20) + 2 * (p + border)
      super(x, y, w, h)
      self.opacity = TETRIS_FIELD[:T]
      self.padding = p
      tetris_bitmap(x + 5, y + 5, 100)
    end
      
    def block_size
      Tetris_Process::block_size_with_border 
    end 
  
    def tetris_bitmap(x, y, z)
      field_rows, field_columns, p = 20, 10, padding
      @field = Tetris_Field.new( x + p, y + p, field_rows, field_columns, self.z)
    end  
  
    def clear_field; @field.clear_field end  
  
  end  #Window_TetrisField
    
# ===========================================================================
#                    ▼ class Window Block 1
# ===========================================================================    
  
  class Window_Block1 < Window_Base
  
    attr_reader :field
  
    def initialize
      x = WINDOW_BLOCK_1[:X]; y = WINDOW_BLOCK_1[:Y]
      w = WINDOW_BLOCK_1[:W]; h = WINDOW_BLOCK_1[:H]
      p = WINDOW_BLOCK_1[:P]
      p = standard_padding unless p
      super(x, y, w, h)
      self.opacity = WINDOW_BLOCK_1[:T]
      self.padding = p
      contents.font.size  = WINDOW_BLOCK_1[:FS]
      create_field; draw_stats
    end  
  
    def create_field
      border = 5
      x = self.x + padding
      @field_y = self.y + border + padding + contents.font.size
      w = self.width - block_size/2; h = self.height - block_size/2
      field_rows, field_columns = 3, 4;
      @field = Tetris_Field_Base.new(x, @field_y, field_rows, field_columns, self.z)
    end  
    
    def block_size
      processor::block_size_with_border
    end 
    
    def symb_add
       VOCAB[:added_symbol]
    end  
     
    def timer_check
       update_timer if @timer_seconds < processor::total_seconds
    end
	
    def update_level(init = true)
      vocab = VOCAB[:level]
      str_1 = vocab + symb_add; str_2 = level
      width = text_size(str_1).width
      clwidth = text_size(str_2).width + 1
      height = text_size(str_1).height
      contents.clear_rect(width, initial_y, width, height) 
      draw_text_ex(0, initial_y, str_1) if init
      draw_text_ex(width, initial_y, str_2)
    end  
    
    def update_actions(init = false)
      vocab = VOCAB[:actions]
      str_1 = vocab + symb_add; str_2 = actions
      width = text_size(str_1).width
      clwidth = text_size(str_2).width + 1
      height = text_size(str_1).height
      contents.clear_rect(width, initial_y + line_distance, clwidth, height) 
      draw_text_ex(0, initial_y + line_distance, str_1) if init
      draw_text_ex(width, initial_y + line_distance, str_2)
    end  
    
    def update_cleared_lines(init = false)
      vocab = VOCAB[:cleared_lines]
      str_1 = vocab + symb_add; str_2 = deleted_lines
      width = text_size(str_1).width
      clwidth = text_size(str_2).width + 1
      height = text_size(str_1).height
      contents.clear_rect(width, initial_y + line_distance * 2, clwidth, height)
      draw_text_ex(0, initial_y + line_distance * 2, str_1) if init
      draw_text_ex(width, initial_y + line_distance * 2, str_2)
    end  
    
    def update_scores(init = false)
      vocab = VOCAB[:scores]
      str_1 = vocab + symb_add; str_2 = scores.to_s
      width = text_size(str_1).width
      clwidth = text_size(str_2).width + 1
      height = text_size(str_1).height
      contents.clear_rect(width, initial_y + line_distance * 3, clwidth, height) 
      draw_text_ex(0, initial_y + line_distance * 3, str_1) if init
      contents.font.color = text_color(best_scores_color) if processor.new_record?
      width = text_size(str_1).width
      draw_text_ex(width, initial_y + line_distance * 3, str_2)
      contents.font.color = normal_color
    end  
    
    def update_best_scores(init = false)
      vocab = VOCAB[:best_scores]
      str_1 = vocab + symb_add; str_2 = best_scores.to_s
      width = text_size(str_1).width
      clwidth = text_size(str_2).width + 1
      height = text_size(str_1).height
      contents.clear_rect(width, initial_y + line_distance * 4, clwidth, height) 
      draw_text_ex(0, initial_y + line_distance * 4, str_1) if init
      contents.font.color = text_color(best_scores_color) if processor.new_record?
      width = text_size(str_1).width
      draw_text_ex(width, initial_y + line_distance * 4, str_2)
      contents.font.color = normal_color
    end  
    
    def update_timer(init = false)
      @timer_seconds = processor::total_seconds
      vocab = VOCAB[:timer]
      str_1 = vocab + symb_add
      str_2 = processor.timer_to_string
      width = text_size(str_1).width
      clwidth = text_size(str_2).width + 1
      height = text_size(str_1).height
      contents.clear_rect(width, initial_y + line_distance * 5, clwidth, height)
      draw_text_ex(0, initial_y + line_distance* 5, str_1) if init
      width = text_size(vocab + symb_add).width
      draw_text_ex(width, initial_y + line_distance * 5, str_2)
    end  
        
    def draw_stats
      contents.clear
      contents.font.color = normal_color
      draw_text_ex(0, 0, VOCAB[:next_tetro] + VOCAB[:added_symbol])
      
      update_level(true);  update_actions(true);     update_cleared_lines(true)
      update_scores(true); update_best_scores(true); update_timer(true)
    end  
   
    def initial_y;          contents.font.size + block_size * 3 end                         
	  def line_distance;      WINDOW_BLOCK_1[:LD]                 end
    def best_scores_color;  BEST_SCORES_TEXT_COLOR              end
    def reset_font_settings;                                    end
    def actions;            processor.actions.to_s              end
    def level;              processor.level.to_s                end
    def scores;             processor.scores                    end
    def best_scores;        processor.best_scores               end
    def deleted_lines;      processor.deleted_lines.to_s        end
    def processor;          Tetris_Process                      end
      
  end #Window_Block1 

# ===========================================================================
#                    ▼ class Window Pause
# =========================================================================== 

  class Window_Pause < Window_Command 
    
    def initialize
      x = WINDOW_PAUSE[:X]; y = WINDOW_PAUSE[:Y]
      w = WINDOW_PAUSE[:W]; h = WINDOW_PAUSE[:H]
      p = WINDOW_PAUSE[:P]
      p = standard_padding unless p
      super(w, h)
      self.x = x; self.y = y
      self.width = w; self.height = h
      self.opacity = WINDOW_PAUSE[:T]
      self.padding = p
      contents.font.size = WINDOW_PAUSE[:FS]
      set_commands
      select(0)
    end
    
    def set_commands(value = VOCAB[:new_game])
      @start_resume = value
      refresh
    end  
  
    def make_command_list
      add_command(@start_resume, :start_tetris)
      add_command(VOCAB[:exit_scene], :exit)
    end
    
    def refresh
      clear_command_list; make_command_list
      contents.clear;     draw_all_items
    end  
  
    def reset_font_settings;                   end
    def line_height;         WINDOW_PAUSE[:FS] end
  
  end #Window_Pause
    
# ===========================================================================
#                    ▼ class Window Block 2
# ===========================================================================
  
  class Window_Block2 < Window_Base
    
    def initialize
      x = WINDOW_BLOCK_2[:X]; y = WINDOW_BLOCK_2[:Y]
      w = WINDOW_BLOCK_2[:W]; h = WINDOW_BLOCK_2[:H]
      p = WINDOW_BLOCK_2[:P]
      p = standard_padding unless p
      super(x, y, w, h)
      self.opacity = WINDOW_BLOCK_2[:T]
      self.padding = p
      return_clocks
      draw_control_contents
    end
      
    def draw_control_contents
      clear_contents
      line_distance = WINDOW_BLOCK_2[:LD]
      contents.font.size = WINDOW_BLOCK_2[:FS_1]
      contents.font.color = normal_color
      text = DISPLAY_CONTROLS
      x = ( self.width - text_size(text[0]).width) / 2 - padding
      draw_text_ex(x, 0, text[0] )
      for i in 1...text.size do draw_text_ex(0, line_distance * i, text[i]) end  
    end  
    
    def game_over_contents
      clear_contents
      contents.font.size = WINDOW_BLOCK_2[:FS_2]
      contents.font.color = normal_color
      game_over_str = VOCAB[:game_over]
      x = ( self.width - text_size(game_over_str).width) / 2 - padding
      draw_text_ex(x, 0, game_over_str )
    end
  
    def flash_contents
      return if @clock == -1
      #game_over_contents if @clock % (Graphics.frame_rate/2) == 0
      if @clock % (Graphics.frame_rate/2) == 0 && !flash_condition
        r = Rect.new(0, WINDOW_BLOCK_2[:FS_2], width, height)
        contents.clear_rect(r)
      end
      if flash_condition
        contents.font.size = WINDOW_BLOCK_2[:FS_3]
        contents.font.color = text_color(2) if Tetris_Process::new_record?
        text = VOCAB[:new_high_scores1] + "\n"
        text += VOCAB[:new_high_scores2]
        draw_text_ex(0, WINDOW_BLOCK_2[:FS_2], text ) if flash_condition
      end
    end 
   
    def flash_condition
      @clock % Graphics.frame_rate == 0 && Tetris_Process.new_record?
    end  
           
    def refresh
      @clock += 1 if working?
      call_handler if @clock == @final_clock
      flash_contents
    end
    
    def final_clock=(value)
      val = value.floor #in case developer provided float by mistake
      @final_clock = val > Graphics.frame_rate ? val : Graphics.frame_rate
      game_over_contents
    end
    
    def return_clocks
      @final_clock =-1; @clock = 0
    end  
          
    def clear_contents;      contents.clear                  end  
    def best_scores_color;   BEST_SCORES_TEXT_COLOR          end
    def working?;            @final_clock >= 0               end  
    def set_handler(method); @handler = method               end
    def call_handler;        return_clocks; @handler.call    end
    def reset_font_settings;                                 end
  
  end #Window_Block2
    
# ===========================================================================
#                    ▼ class Tetris Row
# ===========================================================================   
  
  class Tetris_Row
    
    attr_reader :blocks
    
    def initialize(blocks)
      assign_row(blocks)
    end
    
    def assign_row(blocks)
      @blocks = blocks
    end  
    
    #checks if row is full.
    def full?
      @blocks.each do |block| return false if block.value == 0; end 
      return true
    end
    
    def any?
      @blocks.each do |block| return true if block.value > 0;  end
      return false
    end  
    
    #takes the color values of other row
    def take_from(the_other_row)
      @blocks.each_index do |x|
        @blocks[x].value = the_other_row.blocks[x].value
      end
    end 
    
    #deletes the color values within the row
    def delete_row
      @blocks.each do |block| block.value = 0; end
    end  
      
  end #Tetris_Row
  
# ===========================================================================
#                    ▼ class Tetromino Base
# ===========================================================================   
  
  class Tetromino_Base
    
    attr_reader :game_over_flag, :type
    
    def initialize(blocks,  type)
      @blocks = blocks
      @game_over_flag = false
      @tetromino_blocks = Array.new(4)
      @type = type #pieces type 1: O, 2: L, 3: J, 4: I, 5: S, 6: T, 7: Z
      @type = 1 + rand(7) unless @type.between?(1, 7)
      @base ||= { :x =>1, :y=>2 }
      @base[:y] -= 1 if @type == 4
    end
    
    def spawn
      spawn_block_1; spawn_block_2; spawn_block_3; spawn_block_4 
    end 
    
    def spawn_block_1
      assign_block(0, @base[:x], @base[:y]);
    end  
    
    def spawn_block_2
      case @type
        when 1, 5, 6, 7; assign_block(1, @base[:x],     @base[:y] - 1);
        when 2, 3, 4;    assign_block(1, @base[:x] - 1, @base[:y]    );
      end
    end 
    
    def spawn_block_3
      case @type
        when 1, 2, 5; assign_block(2, @base[:x] + 1, @base[:y] - 1);
        when 3, 7;    assign_block(2, @base[:x] - 1, @base[:y] - 1); 
      end
      assign_block(2, @base[:x] + 2, @base[:y]) if @type == 4
      assign_block(2, @base[:x] - 1, @base[:y]) if @type == 6
    end 
    
    def spawn_block_4
      case @type
        when 1, 2, 3, 4, 6, 7; assign_block(3, @base[:x] + 1, @base[:y]    );
      end
      assign_block(3, @base[:x] - 1, @base[:y]) if @type == 5 
    end  
    
    def block(x, y); @blocks[x][y]; end
    
    def assign_block(index, x, y)
      @tetromino_blocks[index] = block(x, y)
      @game_over_flag = true unless can_spawn?(x, y)
      @tetromino_blocks[index].value = @type
      @tetromino_blocks[index].on_fall = true
    end 
    
    def can_spawn?(x, y)
      (block(x, y).value == 0)
    end  

    def clear_tetromino
      @tetromino_blocks.each do |block|
        block.value = 0; block.on_fall = false
      end
    end
    
  end #Tetromino_Base
  
# ===========================================================================
#                          ▼ class Tetromino
# ===========================================================================   
  
  class Tetromino < Tetromino_Base
    
    def initialize(rows, type)
      @rows = rows
      @base = { :x =>4, :y=>1 }
      super(nil, type)
    end
    
    def block(x, y); 
      @rows[y].blocks[x];
    end

    def move_left;  move(-1, 0); end
    def move_right; move(1,  0); end
    def move_down;  move(0,  1); end
    def move_up;    move(0, -1); end
    
    def move(x_offset, y_offset)
      return false unless can_move?(x_offset, y_offset)
      tetromino = @tetromino_blocks
      @base[:x] += x_offset; @base[:y] += y_offset
      clear_tetromino
      tetromino.each_index do |i|
        x = tetromino[i].x;  y = tetromino[i].y
        tetromino[i] = block(x + x_offset, y + y_offset)
        tetromino[i].value = @type; tetromino[i].on_fall = true
      end
      return true
    end  
    
    def assign_squares(new_shape)
      @tetromino_blocks = new_shape
      @tetromino_blocks.each do |block|
        block.value = @type; block.on_fall = true 
      end  
    end
    
    def can_move?(x_offset, y_offset)
      @tetromino_blocks.each do |block|
        return false if !(block.y + y_offset).between?(0, 19)
        return false if !(block.x + x_offset).between?(0, 9)
        next_block = self.block(block.x + x_offset, block.y + y_offset)
        return false unless next_block.value == 0 || next_block.on_fall
      end 
      return true
    end
    
    def rotate(dir_multiplier, recursive = false)
      return if @type == 1 #O piece doesn't rotate.
      new_shape = Array.new
      base_block = block(@base[:x], @base[:y])
      @tetromino_blocks.each_index do |i|
        #loop --------------------------------------------------#
        x_offset = base_block.y - @tetromino_blocks[i].y
        y_offset = (@tetromino_blocks[i].x - base_block.x)  
        new_x = base_block.x + ( x_offset * dir_multiplier )
        new_y = base_block.y + ( y_offset * dir_multiplier )
        if (!new_x.between?(0, 9) || !new_y.between?(0, 19))
          if (new_x == (-1) || new_x == 10 || new_y == (-1))
            return wall_kick(x_offset, y_offset, dir_multiplier) unless recursive
          end
        return false
        end
        new_block = block(new_x, new_y)
        if (new_block.value > 0 && !new_block.on_fall)
          return wall_kick(x_offset, 0, dir_multiplier) unless recursive
          return false
        end 
        new_shape << new_block 
        #end loop---------------------------------------------------
      end
        clear_tetromino
        assign_squares(new_shape)
        return true
    end
    
    def wall_kick(x_offset, y_offset, dir_multiplier)
      base_x = @base[:x]; base_y = @base[:y]
      recursive = true
      if x_offset != 0
        if move_left
          if rotate(dir_multiplier, recursive); return true end  
          move_right
        end  
        if move_right
          if rotate(dir_multiplier, recursive); return true end  
          move_left
        end 
      end  
      if y_offset != 0
        if move_down
          if rotate(dir_multiplier, recursive); return true end
          move_up
          return false
        end  
      end  
    end  
     
    def deactivate
      @game_over_flag = false
      @tetromino_blocks.each do |block| block.on_fall = false; end
    end  
	
	  def rotate_clockwise;         rotate( 1)      end     
    def rotate_counter_clockwise; rotate(-1)      end 
    def fall;                     move_down;      end  
    def can_fall?;                can_move?(0, 1) end  
    
  end #Tetromino
  
# ===========================================================================
#                      ▼ class Building Block
# ===========================================================================   
  
  class Building_Block
    
    attr_accessor :on_fall
    attr_reader   :x, :y, :value
    
    def initialize(field, x, y)
      @field = field
      create_rect(x, y)
      @on_fall = false
      self.value = 0 
    end
    
    def create_rect(x, y)
      @rect = Rect.new
      self.x = x; self.y = y
      @rect.height = block_size
      @rect.width = block_size
    end  
    
    def value=(value)
      @value = value
      @value = 0 unless @value.between?(0 ,7)
      color = Tetris_Process::generate_color(COLORS[@value])
      @field.bitmap.fill_rect( @rect, color)
    end 
    
    def x=(value) 
      @x = value
      @rect.x = value * ( block_size + block_distance) 
    end
    
    def y=(value) 
      @y = value 
      @rect.y = value * ( block_size + block_distance) 
    end

    def block_size;     BLOCK_SIZE;      end  
    def block_distance; BLOCKS_DISTANCE; end     
	
  end  #Building_Block
    
end  #GGZiron_Tetris module

# ===========================================================================
#                     ▼ module Data Manager
# ===========================================================================  

module DataManager
  
  class <<self
    alias_method :make_save_contents_oldggz424,    :make_save_contents
    alias_method :extract_save_contents_oldggz424, :extract_save_contents
    alias_method :create_game_objects_oldggz424,   :create_game_objects
  end
  
  def self.make_save_contents(*args)
     contents = make_save_contents_oldggz424(*args)
     GGZiron_Tetris::Tetris_Process::make_save_contents(contents)
  end
   
  def self.extract_save_contents(*args)
    extract_save_contents_oldggz424(*args)
    GGZiron_Tetris::Tetris_Process::extract_save_data(args[0])
  end
  
  def self.create_game_objects(*args)
    create_game_objects_oldggz424(*args)
    GGZiron_Tetris::Tetris_Process::initialize_data
  end
  
end #DataManager

# ===========================================================================
#                     ▼ class Scene Menu
# =========================================================================== 

class Scene_Menu < Scene_MenuBase
  
  alias_method :create_comand_window_ggz54314, :create_command_window
  
  def create_command_window(*args)
    create_comand_window_ggz54314(*args)
    @command_window.set_handler(:tetris_ggz54314, method(:play_tetris_ggz54314))
  end
  
  def play_tetris_ggz54314
    SceneManager.call(GGZiron_Tetris::Scene_Tetris)
  end  
  
end #Scene_Menu

# ===========================================================================
#                   ▼ class Window Menu Command 
# =========================================================================== 

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
# ===========================================================================
#                         END OF FILE
# ===========================================================================
