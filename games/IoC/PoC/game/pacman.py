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

import pygame.transform

from direction import Direction
from sprite import Sprite


class PacMan(Sprite):
    def __init__(self, surface, images_path, filename_prefix):
        super(PacMan, self).__init__(surface, images_path)
        self._tick = 0

        img_full = self.loadImage(filename_prefix, "full")
        img_half = self.loadImage(filename_prefix, "half")
        img_open = self.loadImage(filename_prefix, "open")

        self._sprites = {}

        # this is default direction
        self._sprites[Direction.RIGHT] = (img_full, img_half, img_open)

        # rotate left by 90 degrees
        img_full = pygame.transform.rotate(img_full, 90)
        img_half = pygame.transform.rotate(img_half, 90)
        img_open = pygame.transform.rotate(img_open, 90)
        self._sprites[Direction.UP] = (img_full, img_half, img_open)

        # rotate left by 90 degrees
        img_full = pygame.transform.rotate(img_full, 90)
        img_half = pygame.transform.rotate(img_half, 90)
        img_open = pygame.transform.rotate(img_open, 90)
        self._sprites[Direction.LEFT] = (img_full, img_half, img_open)

        # rotate left by 90 degrees
        img_full = pygame.transform.rotate(img_full, 90)
        img_half = pygame.transform.rotate(img_half, 90)
        img_open = pygame.transform.rotate(img_open, 90)
        self._sprites[Direction.DOWN] = (img_full, img_half, img_open)

    def draw(self):
        self._surface.blit(self._sprites[self._direction][self._tick], (self._x, self._y))

    def tick(self):
        self._tick += 1
        if self._tick > 3:
            self._tick = 0
