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

"""Ghost class that represents any ghost in the game."""

from enum import Enum
from typing import Any, Dict

import pygame
from direction import Direction
from resources import Resources
from sprite import Sprite


class Scared(Enum):
    """Enumeration with all sprites for 'scared' ghosts."""

    SCARED1 = 5
    SCARED2 = 6


class Ghost(Sprite):
    """Ghost class that represents any ghost in the game."""

    def __init__(self, surface: pygame.Surface, resources: Resources,
            filename_prefix: str) -> None:
        """Ghost object initialization, including resource loading."""
        super(Ghost, self).__init__(surface)

        self._scared = False
        self._scared_tick = 0

        self._sprites :Dict[Any, Any] = {}
        self._sprites[Direction.LEFT] = resources.images[filename_prefix+"_left"]
        self._sprites[Direction.RIGHT] = resources.images[filename_prefix+"_right"]
        self._sprites[Direction.UP] = resources.images[filename_prefix+"_up"]
        self._sprites[Direction.DOWN] = resources.images[filename_prefix+"_down"]
        self._sprites[Scared.SCARED1] = resources.images["ghost_scared_1"]
        self._sprites[Scared.SCARED2] = resources.images["ghost_scared_2"]

    def setScared(self, scared: bool) -> None:
        """Set 'scared ghost' mode."""
        self._scared = scared

    def draw(self) -> None:
        """Draw ghost onto the screen or onto surface selected during initialization."""
        if self._scared:
            if self._scared_tick == 0:
                self._surface.blit(self._sprites[Scared.SCARED1], (self._x, self._y))
            else:
                self._surface.blit(self._sprites[Scared.SCARED2], (self._x, self._y))
        else:
            self._surface.blit(self._sprites[self._direction], (self._x, self._y))
