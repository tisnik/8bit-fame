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

"""PacMan class that represents Pac man in the game."""

import pygame.transform

from direction import Direction
from sprite import Sprite


class PacMan(Sprite):
    """PacMan class that represents Pac man in the game."""

    def __init__(self, surface, resources, filename_prefix):
        """Object initialization, including resource loading."""
        super(PacMan, self).__init__(surface)
        self._tick = 0

        img_full = resources.images[filename_prefix+"_full"]
        img_half = resources.images[filename_prefix+"_half"]
        img_open = resources.images[filename_prefix+"_open"]

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
        """Draw Pac Man onto the screen or onto surface selected during initialization."""
        self._surface.blit(self._sprites[self._direction][self._tick], (self._x, self._y))

    def tick(self):
        """Change sprite on screen according to clock ticks."""
        self._tick += 1
        if self._tick > 3:
            self._tick = 0
