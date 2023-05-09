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


class PacMan(Sprite):
    def __init__(self, display, filename_prefix):
        self._direction = Direction.LEFT
        self._display = display

        self._sprites = {}
        self._sprites[Direction.LEFT] = self.loadImage(filename_prefix, "full")

    def draw(self):
        self._display.blit(self._sprites[self._direction], (10, 10))
