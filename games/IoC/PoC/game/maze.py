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

"""Representation of maze in a game."""

import os
import pygame

from tile import Tile

class Maze:
    """Representation of maze in a game."""

    WALL_COLOR = (120, 120, 255)

    def __init__(self, display, configuration, maze_name):
        self._display = display

        maze_directory = configuration["paths"]["mazes"]
        filename = os.path.join(maze_directory, maze_name)
        raw_data = self.loadMaze(filename)
        self._tiles = parseTiles(raw_data)

    def loadMaze(self, filename):
        with open(filename, "r") as fin:
            lines = fin.readlines()
        return lines

    def draw(self):
        y = 20
        for row in self._tiles:
            x = 32
            for tile in row:
                pygame.draw.rect(self._display,
                                 Maze.WALL_COLOR,
                                 pygame.Rect(x, y, 30, 30))
                x += 32
            y += 32


def parseTiles(raw_data):
    rows = []
    for line in raw_data:
        line = line[:-1]
        row = []
        for char in line:
            row.append(Tile(char))
        rows.append(row)
    return rows
