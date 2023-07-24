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
import configparser

from typing import Dict, List, Tuple, Optional
from tile import Tile


class Maze:
    """Representation of maze in a game."""

    def __init__(self, display: pygame.Surface, configuration: configparser.ConfigParser, maze_name: str) -> None:
        """Initialize maze by loading its topology from external text file."""
        self._display = display

        maze_directory = configuration["paths"]["mazes"]
        filename = os.path.join(maze_directory, maze_name)
        raw_data = self.loadMaze(filename)
        self._tiles = parse_tiles(raw_data)
        self._back_buffer = pygame.Surface(display.get_size())
        self.drawMaze(self._back_buffer)
        self._ghost_positions = compute_ghost_positions(raw_data)
        self._pacman_position = compute_pacman_position(raw_data)

    def getGhostPositions(self) -> Dict[str, Optional[Tuple[int, int]]]:
        return self._ghost_positions

    def getPacmanPosition(self) -> Optional[Tuple[int, int]]:
        return self._pacman_position

    def loadMaze(self, filename: str) -> List[str]:
        """Load maze topology from external text file."""
        with open(filename, "r") as fin:
            lines = fin.readlines()
        return lines

    def drawMaze(self, surface: pygame.Surface) -> None:
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


def parse_tiles(raw_data: List[str]) -> List[List[Tile]]:
    """Parse titles character by character."""
    rows = []
    for line in raw_data:
        line = line[:-1]
        row = []
        for char in line:
            row.append(Tile(char))
        rows.append(row)
    return rows


def compute_ghost_positions(raw_data: List[str])-> Dict[str, Optional[Tuple[int, int]]]:
    return {
            "red": find_char_position_in_raw_data(raw_data, "R"),
            "cyan": find_char_position_in_raw_data(raw_data, "C"),
            "green": find_char_position_in_raw_data(raw_data, "G"),
            "pink": find_char_position_in_raw_data(raw_data, "P"),
            }


def compute_pacman_position(raw_data: List[str]) -> Optional[Tuple[int, int]]:
    return find_char_position_in_raw_data(raw_data, "M")


def find_char_position_in_raw_data(raw_data: List[str], char: str) -> Optional[Tuple[int, int]]:
    y = 0
    for line in raw_data:
        x = line.find(char)
        if x >= 0:
            return (x+1, y+1)
        y += 1
    return None
