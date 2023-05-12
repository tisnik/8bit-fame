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

import pygame
import os

from direction import Direction
from config import IMAGES_PATH


class Sprite:
    """Super class for all movable objects in the game."""

    def __init__(self, surface):
        """Initialize the sprite."""

        # most sprites can be rotated in four directions
        self._direction = Direction.RIGHT

        # absolute position of sprite on screen
        self._x = 0
        self._y = 0

        # surface used to display the sprite
        self._surface = surface

    def draw(self):
        """Elementary draw method to be overwritten in derived classes."""
        self._surface.blit(self._sprites[self._direction], (self._x, self._y))

    def loadImage(self, filename_prefix, filename_suffix):
        """Load image for sprite."""
        filename = f"{filename_prefix}_{filename_suffix}.png"
        return pygame.image.load(os.path.join(IMAGES_PATH, filename))

    def setDirection(self, direction):
        """Set sprite direction (if applicable)."""
        self._direction = direction

    def cycleDirection(self):
        self._direction = self._direction.succ()

    def setPosition(self, x, y):
        """Set sprite position."""
        self._x = x
        self._y = y

    def move(self, step=1):
        """Move sprite in actual direction."""
        if self._direction == Direction.UP:
            self._y -= step
        elif self._direction == Direction.DOWN:
            self._y += step
        if self._direction == Direction.LEFT:
            self._x -= step
        elif self._direction == Direction.RIGHT:
            self._x += step

    def moveTo(self, x, y):
        """Move sprite to absolute position."""
        self._x = x
        self._y = y

    def moveRel(self, dx, dy):
        """Move sprite to relative position."""
        self._x += dx
        self._y += dy
