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


def draw_default(display: pygame.Surface, x: int, y: int) -> None:
    pygame.draw.rect(display,
                     Tile.WALL_COLOR,
                     pygame.Rect(x, y, 30, 30))


def draw_blank(display: pygame.Surface, x: int, y: int) -> None:
    pass


def draw_horizontal_line(display: pygame.Surface, x: int, y: int) -> None:
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+14), (x+31, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+17), (x+31, y+17))


def draw_left_half_horizontal_line(display: pygame.Surface, x: int, y: int) -> None:
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+14), (x+16, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+17), (x+16, y+17))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+16, y+14), (x+16, y+17))


def draw_right_half_horizontal_line(display: pygame.Surface, x: int, y: int) -> None:
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+16, y+14), (x+31, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+16, y+17), (x+31, y+17))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+16, y+14), (x+16, y+17))


def draw_vertical_line(display: pygame.Surface, x: int, y: int) -> None:
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y), (x+14, y+31))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y), (x+17, y+31))


def draw_top_half_vertical_line(display: pygame.Surface, x: int, y: int) -> None:
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y), (x+14, y+16))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y), (x+17, y+16))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y+16), (x+17, y+16))


def draw_bottom_half_vertical_line(display: pygame.Surface, x: int, y: int) -> None:
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y+16), (x+14, y+31))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y+16), (x+17, y+31))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y+16), (x+17, y+16))


def draw_top_left_corner(display: pygame.Surface, x: int, y: int) -> None:
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


def draw_top_right_corner(display: pygame.Surface, x: int, y: int) -> None:
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


def draw_bottom_left_corner(display: pygame.Surface, x: int, y: int) -> None:
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


def draw_upper_t(display: pygame.Surface, x: int, y: int) -> None:
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+14), (x+31, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+17), (x+14, y+17))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y+17), (x+31, y+17))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y+17), (x+14, y+31))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y+17), (x+17, y+31))


def draw_left_t(display: pygame.Surface, x: int, y: int) -> None:
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y), (x+14, y+31))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y), (x+17, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y+17), (x+17, y+31))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y+14), (x+31, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y+17), (x+31, y+17))


def draw_right_t(display: pygame.Surface, x: int, y: int) -> None:
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y), (x+14, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+14, y+17), (x+14, y+31))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+14), (x+14, y+14))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x, y+17), (x+14, y+17))
    pygame.draw.line(display,
                     Tile.WALL_COLOR,
                     (x+17, y), (x+17, y+31))


def draw_big_dot(display: pygame.Surface, x: int, y: int) -> None:
    pygame.draw.circle(display, Tile.DOT_COLOR,
                     (x+16, y+16), 10)


def draw_small_dot(display: pygame.Surface, x: int, y: int) -> None:
    pygame.draw.circle(display, Tile.DOT_COLOR,
                     (x+16, y+16), 4)


def draw_bottom_right_corner(display: pygame.Surface, x: int, y: int) -> None:
    c = (255, 255, 255)
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
    DOT_COLOR = (255, 255, 120)

    types = {
            "┌": TileType.TOP_LEFT_CORNER,
            "┐": TileType.TOP_RIGHT_CORNER,
            "└": TileType.BOTTOM_LEFT_CORNER,
            "┘": TileType.BOTTOM_RIGHT_CORNER,
            "─": TileType.HORIZONTAL_LINE,
            "╴": TileType.LEFT_HALF_HORIZONTAL_LINE,
            "╶": TileType.RIGHT_HALF_HORIZONTAL_LINE,
            "│": TileType.VERTICAL_LINE,
            "╵": TileType.TOP_HALF_VERTICAL_LINE,
            "╷": TileType.BOTTOM_HALF_VERTICAL_LINE,
            "┬": TileType.UPPER_T,
            "├": TileType.LEFT_T,
            "┤": TileType.RIGHT_T,
            "*": TileType.BIG_DOT,
            ".": TileType.SMALL_DOT,
            " ": TileType.EMPTY,
            "R": TileType.RED_GHOST,
            "C": TileType.CYAN_GHOST,
            "G": TileType.GREEN_GHOST,
            "P": TileType.PINK_GHOST,
            "M": TileType.PACMAN,
            }

    draw_methods = {
            TileType.TOP_LEFT_CORNER: draw_top_left_corner,
            TileType.TOP_RIGHT_CORNER: draw_top_right_corner,
            TileType.BOTTOM_LEFT_CORNER: draw_bottom_left_corner,
            TileType.BOTTOM_RIGHT_CORNER: draw_bottom_right_corner,
            TileType.HORIZONTAL_LINE: draw_horizontal_line,
            TileType.LEFT_HALF_HORIZONTAL_LINE: draw_left_half_horizontal_line,
            TileType.RIGHT_HALF_HORIZONTAL_LINE: draw_right_half_horizontal_line,
            TileType.VERTICAL_LINE: draw_vertical_line,
            TileType.TOP_HALF_VERTICAL_LINE: draw_top_half_vertical_line,
            TileType.BOTTOM_HALF_VERTICAL_LINE: draw_bottom_half_vertical_line,
            TileType.UPPER_T: draw_upper_t,
            TileType.LEFT_T: draw_left_t,
            TileType.RIGHT_T: draw_right_t,
            TileType.BIG_DOT: draw_big_dot,
            TileType.SMALL_DOT: draw_small_dot,
            TileType.EMPTY: draw_blank,
            TileType.RED_GHOST: draw_blank,
            TileType.CYAN_GHOST: draw_blank,
            TileType.GREEN_GHOST: draw_blank,
            TileType.PINK_GHOST: draw_blank,
            TileType.PACMAN: draw_blank,
            }

    def __init__(self, raw_char) -> None:
        self._type = Tile.types[raw_char]
        self.draw = self.draw_methods[self._type]
