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
from statistic import Statistic, loadStatistic, saveStatistic
from settings_screen import SettingsScreen
from resources import Resources
from about_screen import AboutScreen

statistic = Statistic()
# save statistic into external file
saveStatistic(statistic)

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

splash_screen = SplashScreen(display, resources, "splash_screen", 8, red_ghost)

while True:
    menuItem = splash_screen.eventLoop()
    if menuItem == MainMenu.QUIT.value:
        pygame.quit()
        sys.exit()
    elif menuItem == MainMenu.SETTINGS.value:
        settings_screen = SettingsScreen(display, resources)
        settings_screen.draw()
        settings_screen.eventLoop()
    elif menuItem == MainMenu.STATISTIC.value:
        statistic_screen = StatisticScreen(display, resources, statistic)
        statistic_screen.draw()
        statistic_screen.eventLoop()
    elif menuItem == MainMenu.ABOUT.value:
        about_screen = AboutScreen(display, resources)
        about_screen.draw()
        about_screen.eventLoop()

# finito
