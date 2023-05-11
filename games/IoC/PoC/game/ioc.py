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

from ghost import Ghost
from pacman import PacMan
from config import WINDOW_WIDTH, WINDOW_HEIGHT, loadConfiguration
from colors import Colors
from direction import Direction
from splash_screen import SplashScreen


configuration = loadConfiguration("ioc.ini")

pygame.init()
clock = pygame.time.Clock()

# create game window
display = pygame.display.set_mode([WINDOW_WIDTH, WINDOW_HEIGHT])

# set window title
pygame.display.set_caption("Inversion of Control")

display.fill(Colors.BLACK.value)


green_ghost = Ghost(display, "ghost_green")
green_ghost.draw()

cyan_ghost = Ghost(display, "ghost_cyan")

pacman = PacMan(display, "pacman")

for i in range(50):
    pacman.tick()
    pacman.move()
    cyan_ghost.move()
    cyan_ghost.move()

pacman.setDirection(Direction.UP)
pacman.draw()

cyan_ghost.setScared(True)
cyan_ghost.draw()

splash_screen = SplashScreen(display, "splash_screen", 8)

while True:
    for event in pygame.event.get():
        if event.type == pygame.locals.QUIT:
            pygame.quit()
            sys.exit()
        if event.type == pygame.locals.KEYDOWN and event.key == pygame.locals.K_ESCAPE:
            pygame.quit()
            sys.exit()
    display.fill(Colors.BLACK.value)
    splash_screen.draw()
    pygame.display.update()
    clock.tick(8)


# finito
