-- IMPORTS

import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import Graphics.X11.ExtraTypes.XF86 -- Audio control keys
import XMonad.Hooks.ManageDocks     -- avoid struts
import XMonad.Hooks.DynamicLog      -- Needed for xmobar `StdinReader` to work
import XMonad.Hooks.EwmhDesktops    -- Needed for rofi to work
import XMonad.Layout.Spacing
import XMonad.Layout.Accordion
import XMonad.Layout.Tabbed

-- Some problems appeared when using ewmh in main
-- https://github.com/xmonad/xmonad/issues/18
-- the above issue provided a satisfactory solution

import qualified XMonad.StackSet as W
import qualified Data.Map        as M


-- Default font
myDefaultFont :: String
myDefaultFont = "xft:Fira Code Nerd Font:pixelsize=18:antialias=true:hinting=true"


-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

mySwitcher, myLauncher :: [Char]
myLauncher = "rofi -no-lazy-grab -show drun -modi drun -theme .config/rofi/launchers/colorful/personal_2.rasi"
mySwitcher = "rofi -no-lazy-grab -show window -theme .config/rofi/launchers/colorful/personal_2.rasi"

myScreenCapture, myWindowCapture :: [Char]
myScreenCapture = "gnome-screenshot"
myWindowCapture = "gnome-screenshot --window --remove-border"

-- The default number of workspaces (virtual screens) and their names
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]


---------------------------------------------------------------------
-- Key bindings


myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    -- launch rofi drun mode
    , ((modm,               xK_p     ), spawn myLauncher)
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
    -- application switcher with rofi
    , ((modm .|. shiftMask, xK_Tab ), spawn mySwitcher)
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    -- Volume control using multmedia keys
    , ((0, xF86XK_AudioLowerVolume   ), spawn "amixer -D pulse set Master 5%-")
    , ((0, xF86XK_AudioRaiseVolume   ), spawn "amixer -D pulse set Master unmute 5%+")
    , ((0, xF86XK_AudioMute          ), spawn "amixer -D pulse set Master toggle")
    , ((modm, xF86XK_AudioLowerVolume), spawn "amixer set Capture 5%-")
    , ((modm, xF86XK_AudioRaiseVolume), spawn "amixer set Capture cap 5%+")
    , ((modm, xF86XK_AudioMute       ), spawn "amixer set Capture toggle")
    -- screen capture
    , ((modm,               xK_s     ), spawn myScreenCapture)
    -- capture the focused window
    , ((modm,               xK_w     ), spawn myWindowCapture)
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]


-- Layouts ----------------------------------------------------------------
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.

mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True
myLayout = avoidStruts $ (myTallSpaced ||| Mirror myTallSpaced ||| tabbedAlways shrinkText myTabTheme)
    where
        myTallSpaced = mySpacing 8 $ Tall 1 (5/100) (1/2)
        myTabTheme = def { fontName = myDefaultFont
                         , activeColor         = "#ff0087"
                         , inactiveColor       = "#121212"
                         , activeBorderColor   = "#ff0087"
                         , inactiveBorderColor = "#121212"
                         , activeTextColor     = "#ffffff"
                         , inactiveTextColor   = "#4e4e4e"
                         , decoHeight          = 24
                         }

-- Window rules -----------------------------------------------------------
myManageHook = composeAll
    [ className =? "stalonetray"    --> doIgnore
    , className =? " "              --> doFloat     -- python figures
    , className =? "matplotlib"     --> doFloat     -- python figures
    , className =? "ipython"        --> doFloat     -- python figures
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

-- Event handling ---------------------------------------------------------
-- EwmhDesktops users should change this to ewmhDesktopsEventHook
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards.
-- To combine event hooks use mappend or mconcat from Data.Monoid.
myEventHook = mempty

-- Status bars and logging ------------------------------------------------
-- Perform an arbitrary action on each internal state change or X event
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
-- myLogHook = dynamicLogWithPP $ def { ppOutput = hPutStrLn xmproc }

-- Startup hook -----------------------------------------------------------
-- Perform an arbitrary action each time xmonad starts or is restarted
myStartupHook = do
    -- spawnOnce "picom --experimental-backends --config /home/andriati/.config/picom/picom.config &"
    spawnOnce "picom --config /home/andriati/.config/picom/picom.config &"
    spawnOnce "monitor_selection"
    spawnOnce "nitrogen --restore &"
    spawnOnce "stalonetray &"

-- Run xmonad
main = do
    xmproc <- spawnPipe "xmobar -x 0 /home/andriati/.config/xmobar/xmobar.config"
    xmonad $ ewmh def
        {
      -- simple stuff
        terminal           = "gnome-terminal",
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = 3,
        modMask            = mod4Mask,
        workspaces         = myWorkspaces,
        normalBorderColor  = "#000000",
        focusedBorderColor = "#ff0087",
      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,
      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = docksEventHook <+> myEventHook,
        logHook            = dynamicLogWithPP $ xmobarPP {
                                    ppOutput = hPutStrLn xmproc,
                                    ppCurrent = xmobarColor "#ff0087" "" .wrap "[" "]",
                                    ppHidden = xmobarColor "#444444" "",
                                    ppSep = "<fc=#ff0087><fn=1> \xe0b0 </fn></fc>",
                                    ppTitle = xmobarColor "#ff0087" "" . shorten 40,
                                    ppLayout = const ""
                                    },
        startupHook        = myStartupHook
    }
