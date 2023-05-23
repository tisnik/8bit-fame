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

class Maze:
    """Representation of maze in a game."""

    def __init__(self, display, configuration, maze_name):
        self._display = display

        maze_directory = configuration["paths"]["mazes"]
        filename = os.path.join(maze_directory, maze_name)
        raw_data = self.loadMaze(filename)

    def loadMaze(self, filename):
        with open(filename, "r") as fin:
            lines = fin.readlines()
        return lines
