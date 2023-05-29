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

import pygame

from tile_type import TileType


def drawDefault(display, x, y):
    pygame.draw.rect(display,
                     Tile.WALL_COLOR,
                     pygame.Rect(x, y, 30, 30))


def drawBlank(display, x, y):
    pass


def drawHorizontalLine(display, x, y):
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+14), (x+31, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+17), (x+31, y+17))



def drawVerticalLine(display, x, y):
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y), (x+14, y+31))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y), (x+17, y+31))


def drawTopLeftCorner(display, x, y):
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+24, y+14), (x+31, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+26, y+17), (x+31, y+17))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y+24), (x+14, y+31))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y+26), (x+17, y+31))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+24, y+14), (x+14, y+24))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+26, y+17), (x+17, y+26))


def drawTopRightCorner(display, x, y):
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+14), (x+8, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+17), (x+7, y+17))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y+24), (x+14, y+31))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y+24), (x+17, y+31))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+8, y+14), (x+17, y+23))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+7, y+17), (x+14, y+24))


def drawBottomLeftCorner(display, x, y):
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+26, y+14), (x+31, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+24, y+17), (x+31, y+17))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y), (x+14, y+9))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y), (x+17, y+7))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y+9), (x+24, y+17))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+16, y+7), (x+25, y+14))


def drawBottomRightCorner(display, x, y):
    c = (255,255,255)
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+14), (x+7, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+17), (x+8, y+17))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y), (x+14, y+7))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y), (x+17, y+8))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+7, y+14), (x+14, y+7))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+8, y+17), (x+17, y+8))


class Tile:
    WALL_COLOR = (120, 120, 255)

    types = {
            "┌":TileType.TOP_LEFT_CORNER,
            "┐":TileType.TOP_RIGHT_CORNER,
            "└":TileType.BOTTOM_LEFT_CORNER,
            "┘":TileType.BOTTOM_RIGHT_CORNER,
            "─":TileType.HORIZONTAL_LINE,
            "╴":TileType.LEFT_HALF_HORIZONTAL_LINE,
            "╶":TileType.RIGHT_HALF_HORIZONTAL_LINE,
            "│":TileType.VERTICAL_LINE,
            "╵":TileType.TOP_HALF_VERTICAL_LINE,
            "╷":TileType.BOTTOM_HALF_VERTICAL_LINE,
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

    draw_methods = {
            TileType.TOP_LEFT_CORNER:drawTopLeftCorner,
            TileType.TOP_RIGHT_CORNER:drawTopRightCorner,
            TileType.BOTTOM_LEFT_CORNER:drawBottomLeftCorner,
            TileType.BOTTOM_RIGHT_CORNER:drawBottomRightCorner,
            TileType.HORIZONTAL_LINE:drawHorizontalLine,
            TileType.LEFT_HALF_HORIZONTAL_LINE:drawDefault,
            TileType.RIGHT_HALF_HORIZONTAL_LINE:drawDefault,
            TileType.VERTICAL_LINE:drawVerticalLine,
            TileType.TOP_HALF_VERTICAL_LINE:drawDefault,
            TileType.BOTTOM_HALF_VERTICAL_LINE:drawDefault,
            TileType.UPPER_T:drawDefault,
            TileType.LEFT_T:drawDefault,
            TileType.RIGHT_T:drawDefault,
            TileType.BIG_DOT:drawDefault,
            TileType.SMALL_DOT:drawDefault,
            TileType.EMPTY:drawBlank,
            TileType.RED_GHOST:drawDefault,
            TileType.CYAN_GHOST:drawDefault,
            TileType.GREEN_GHOST:drawDefault,
            TileType.PINK_GHOST:drawDefault,
            TileType.PACMAN:drawDefault,
            }

    def __init__(self, raw_char):
        self._type = Tile.types[raw_char]
        self.draw = self.draw_methods[self._type]

