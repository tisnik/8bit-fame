# vim: set fileencoding=utf-8

#
#  (C) Copyright 2023  Pavel Tisnovsky
#
#  All rights reserved. This program and the accompanying materials
#  are made available under the terms of the Eclipse Public License v1.0
#  which accompanies this distribution, and is available at
#  http://www.eclipse.org/legal/epl-v10.html
#
#  Contributors:
#      Pavel Tisnovsky
#

"""Entry point to initialization part + entry to the main event loop."""

import sys
import os

import pygame
import pygame.locals

from main_menu import MainMenu
from ghost import Ghost
from pacman import PacMan
from config import loadConfiguration
from colors import Colors
from direction import Direction
from splash_screen import SplashScreen
from statistic_screen import StatisticScreen
from statistic import Statistic
from settings_screen import SettingsScreen
from settings_screen_game_rules import SettingsScreenGameRules
from settings_screen_maze import SettingsScreenMaze
from settings_screen_controls import SettingsScreenControls
from game_screen import GameScreen
from resources import Resources
from about_screen import AboutScreen
from maze import Maze


def about_screen_mode(display: pygame.Surface, resources: Resources) -> None:
    """Game mode with about screen displayed."""
    about_screen = AboutScreen(display, resources)
    about_screen.draw()
    about_screen.eventLoop()


def statistic_screen_mode(display: pygame.Surface, resources: Resources, statistic: Statistic) -> None:
    """Game mode with statistic screen displayed."""
    statistic_screen = StatisticScreen(display, resources, statistic)
    statistic_screen.draw()
    statistic_screen.eventLoop()


def settings_screen_mode(display: pygame.Surface, resources: Resources) -> None:
    """Game mode with settings screen displayed."""
    settings_screen = SettingsScreen(display, resources, cyan_ghost)
    settings_screen.draw()
    settings_screen.eventLoop()


statistic = Statistic()
# save default statistic into external file
if statistic.exists():
    statistic = Statistic.load()
else:
    statistic.save()

configuration = loadConfiguration("ioc.ini")

pygame.init()
resources = Resources(configuration)

clock = pygame.time.Clock()

# create game window
window_width = int(configuration["screen"]["window_width"])
window_height = int(configuration["screen"]["window_height"])
display = pygame.display.set_mode([window_width, window_height])

# set window title
pygame.display.set_caption("Inversion of Control")

display.fill(Colors.BLACK.value)

red_ghost = Ghost(display, resources, "ghost_red")
cyan_ghost = Ghost(display, resources, "ghost_cyan")

splash_screen = SplashScreen(display, resources, "splash_screen", 8, red_ghost)

maze = Maze(display, configuration, "default.txt")

if len(sys.argv) > 1:
    command = sys.argv[1]
    # quick jump to action
    if command == "--start":
        game_screen = GameScreen(display, resources, maze)
        game_screen.draw()
        game_screen.eventLoop()
        sys.exit()
    elif command == "--about":
        about_screen_mode(display, resources)
    elif command == "--statistic":
        statistic_screen_mode(display, resources, statistic)
    elif command == "--settings":
        settings_screen_mode(display, resources)


def main() -> None:
    while True:
        menuItem = splash_screen.eventLoop()
        if menuItem == MainMenu.QUIT.value:
            pygame.quit()
            sys.exit()
        elif menuItem == MainMenu.NEW_GAME.value:
            game_screen = GameScreen(display, resources, maze)
            game_screen.draw()
            game_screen.eventLoop()
        elif menuItem == MainMenu.SETTINGS.value:
            settings_screen = SettingsScreen(display, resources, cyan_ghost)
            settings_screen.draw()
            selected = settings_screen.eventLoop()
            # todo - enums
            if selected == 0:
                maze_screen = SettingsScreenMaze(display, resources, cyan_ghost)
                maze_screen.draw()
                maze_screen.eventLoop()
            if selected == 1:
                rules_screen = SettingsScreenGameRules(display, resources, cyan_ghost)
                rules_screen.draw()
                rules_screen.eventLoop()
            if selected == 2:
                rules_screen = SettingsScreenControls(display, resources, cyan_ghost)
                rules_screen.draw()
                rules_screen.eventLoop()
        elif menuItem == MainMenu.STATISTIC.value:
            statistic_screen = StatisticScreen(display, resources, statistic)
            statistic_screen.draw()
            statistic_screen.eventLoop()
        elif menuItem == MainMenu.ABOUT.value:
            about_screen = AboutScreen(display, resources)
            about_screen.draw()
            about_screen.eventLoop()


main()

# finito
