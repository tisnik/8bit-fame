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


class Ghost(Sprite):
    def __init__(self, display, filename_prefix):
        self._direction = Direction.UP
        self._display = display

        self._sprites = {}
        self._sprites[Direction.LEFT] = self.loadImage(filename_prefix, "left")
        self._sprites[Direction.RIGHT] = self.loadImage(filename_prefix, "right")
        self._sprites[Direction.UP] = self.loadImage(filename_prefix, "up")
        self._sprites[Direction.DOWN] = self.loadImage(filename_prefix, "down")
