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

from enum import Enum

class TileType(Enum):
    TOP_LEFT_CORNER = 0
    TOP_RIGHT_CORNER = 1
    BOTTOM_LEFT_CORNER = 2
    BOTTOM_RIGHT_CORNER = 3
    HORIZONTAL_LINE = 4
    LEFT_HALF_HORIZONTAL_LINE = 5
    RIGHT_HALF_HORIZONTAL_LINE = 6
    VERTICAL_LINE = 7
    TOP_HALF_VERTICAL_LINE = 8
    BOTTOM_HALF_VERTICAL_LINE = 9
    UPPER_T = 10
    LEFT_T = 11
    RIGHT_T = 12
    BIG_DOT = 13
    SMALL_DOT = 14
    EMPTY = 15
    RED_GHOST = 16
    CYAN_GHOST = 17
    GREEN_GHOST = 18
    PINK_GHOST = 19
    PACMAN = 20
