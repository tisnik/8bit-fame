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

statistic = Statistic()
saveStatistic(statistic)

configuration = loadConfiguration("ioc.ini")

pygame.init()
clock = pygame.time.Clock()

# create game window
window_width = int(configuration["screen"]["window_width"])
window_height = int(configuration["screen"]["window_height"])
display = pygame.display.set_mode([window_width, window_height])

# set window title
pygame.display.set_caption("Inversion of Control")

display.fill(Colors.BLACK.value)

images_path = configuration["paths"]["images"]
red_ghost = Ghost(display, images_path, "ghost_red")

green_ghost = Ghost(display, images_path, "ghost_green")
green_ghost.draw()

cyan_ghost = Ghost(display, images_path, "ghost_cyan")

pacman = PacMan(display, images_path, "pacman")

for i in range(50):
    pacman.tick()
    pacman.move()
    cyan_ghost.move()
    cyan_ghost.move()

pacman.setDirection(Direction.UP)
pacman.draw()

cyan_ghost.setScared(True)
cyan_ghost.draw()

splash_screen = SplashScreen(display, images_path, "splash_screen", 8, red_ghost)
menuItem = splash_screen.eventLoop()
if menuItem == MainMenu.QUIT.value:
    pygame.quit()
    sys.exit()
elif menuItem == MainMenu.STATISTIC.value:
    statistic_screen = StatisticScreen(display, statistic)
    statistic_screen.draw()
    statistic_screen.eventLoop()

# finito
