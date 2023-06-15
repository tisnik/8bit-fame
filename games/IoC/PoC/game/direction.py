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

"""Enumeration describing all possible sprite directions."""

from enum import Enum


class Direction(Enum):
    """Enumeration describing all possible sprite directions."""

    UP = 1
    RIGHT = 2
    DOWN = 3
    LEFT = 4

    def succ(self) -> 'Direction':
        """Rotate by switching to the next possible direction."""
        value = self.value + 1
        if value > Direction.LEFT.value:
            # cycle
            return Direction.UP
        return Direction(value)
