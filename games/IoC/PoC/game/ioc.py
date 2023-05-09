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


WIDTH = 640
HEIGHT = 480


pygame.init()
clock = pygame.time.Clock()

# create game window
display = pygame.display.set_mode([WIDTH, HEIGHT])

# set window title
pygame.display.set_caption("Inversion of Control")

# colors
BLACK = (0, 0, 0)

display.fill(BLACK)


green_ghost = Ghost(display, "ghost_green")
green_ghost.draw()


while True:
    for event in pygame.event.get():
        if event.type == pygame.locals.QUIT:
            pygame.quit()
            sys.exit()
        if event.type == pygame.locals.KEYDOWN and event.key == pygame.locals.K_ESCAPE:
            pygame.quit()
            sys.exit()
    pygame.display.update()
    clock.tick(20)


# finito
