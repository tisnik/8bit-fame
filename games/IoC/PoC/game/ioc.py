#!/usr/bin/python3
# vim: set fileencoding=utf-8

import sys

import pygame
import pygame.locals

from game.ghost import Ghost


WIDTH = 640
HEIGHT = 480

IMAGES_PATH = "images"


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