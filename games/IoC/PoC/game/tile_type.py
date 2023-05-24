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
    VERTICAL_LINE = 5
    UPPER_T = 6
    LEFT_T = 7
    RIGHT_T = 8
    BIG_DOT = 9
    SMALL_DOT = 10
    EMPTY = 11
    RED_GHOST = 12
    CYAN_GHOST = 13
    GREEN_GHOST = 14
    PINK_GHOST = 15
    PACMAN = 16
