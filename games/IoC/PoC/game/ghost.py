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

from direction import Direction
from sprite import Sprite
from enum import Enum


class Scared(Enum):
    SCARED1 = 5
    SCARED2 = 6


class Ghost(Sprite):
    def __init__(self, display, filename_prefix):
        super(Ghost, self).__init__(display)

        self._scared = False
        self._scared_tick = 0

        self._sprites = {}
        self._sprites[Direction.LEFT] = self.loadImage(filename_prefix, "left")
        self._sprites[Direction.RIGHT] = self.loadImage(filename_prefix, "right")
        self._sprites[Direction.UP] = self.loadImage(filename_prefix, "up")
        self._sprites[Direction.DOWN] = self.loadImage(filename_prefix, "down")
        self._sprites[Scared.SCARED1] = self.loadImage("ghost", "scared_1")
        self._sprites[Scared.SCARED2] = self.loadImage("ghost", "scared_2")

    def setScared(self, scared):
        self._scared = scared

    def draw(self):
        if self._scared:
            if self._scared_tick == 0:
                self._display.blit(self._sprites[Scared.SCARED1], (self._x, self._y))
            else:
                self._display.blit(self._sprites[Scared.SCARED2], (self._x, self._y))
        else:
            self._display.blit(self._sprites[self._direction], (self._x, self._y))
