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

    def __init__(self, display, configuration, maze_name):
        """Initialize maze by loading its topology from external text file."""
        self._display = display

        maze_directory = configuration["paths"]["mazes"]
        filename = os.path.join(maze_directory, maze_name)
        raw_data = self.loadMaze(filename)
        self._tiles = parse_tiles(raw_data)
        self._back_buffer = pygame.Surface(display.get_size())
        self.drawMaze(self._back_buffer)

    def loadMaze(self, filename):
        """Load maze topology from external text file."""
        with open(filename, "r") as fin:
            lines = fin.readlines()
        return lines

    def drawMaze(self, surface) -> None:
        """Draw the whole maze onto the surface."""
        y = 20
        for row in self._tiles:
            x = 32
            for tile in row:
                tile.draw(surface, x, y)
                x += 32
            y += 32

    
    def draw(self) -> None:
        """Draw the whole maze onto the screen."""
        self._display.blit(self._back_buffer, dest=(0,0))


def parse_tiles(raw_data):
    """Parse titles character by character."""
    rows = []
    for line in raw_data:
        line = line[:-1]
        row = []
        for char in line:
            row.append(Tile(char))
        rows.append(row)
    return rows
