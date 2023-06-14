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

"""Super class for all movable objects in the game."""

from abc import ABC
from direction import Direction


class Sprite(ABC):
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

    def draw(self) -> None:
        """Elementary draw method to be overwritten in derived classes."""
        pass

    def setDirection(self, direction) -> None:
        """Set sprite direction (if applicable)."""
        self._direction = direction

    def cycleDirection(self) -> None:
        """Rotate the sprite by switching to the next possible direction."""
        self._direction = self._direction.succ()

    def setPosition(self, x: int, y: int):
        """Set sprite position."""
        self._x = x
        self._y = y

    def getPosition(self):
        """Get sprite position."""
        return (self._x, self._y)

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

    def moveTo(self, x: int, y: int):
        """Move sprite to absolute position."""
        self._x = x
        self._y = y

    def moveRel(self, dx: int, dy: int):
        """Move sprite to relative position."""
        self._x += dx
        self._y += dy
