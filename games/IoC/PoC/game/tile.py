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

from tile_type import TileType

class Tile:
    types = {
            "┌":TileType.TOP_LEFT_CORNER,
            "┐":TileType.TOP_RIGHT_CORNER,
            "└":TileType.BOTTOM_LEFT_CORNER,
            "┘":TileType.BOTTOM_RIGHT_CORNER,
            "─":TileType.HORIZONTAL_LINE,
            "│":TileType.VERTICAL_LINE,
            "┬":TileType.UPPER_T,
            "├":TileType.LEFT_T,
            "┤":TileType.RIGHT_T,
            "*":TileType.BIG_DOT,
            ".":TileType.SMALL_DOT,
            " ":TileType.EMPTY,
            "R":TileType.RED_GHOST,
            "C":TileType.CYAN_GHOST,
            "G":TileType.GREEN_GHOST,
            "P":TileType.PINK_GHOST,
            "M":TileType.PACMAN,
            }

    def __init__(self, raw_char):
        self._type = Tile.types[raw_char]
