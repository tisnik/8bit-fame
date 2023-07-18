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

"""Game screen displayed in the game and selected from main menu."""

import sys
import pygame

from screen import Screen
from colors import Colors
from resources import Resources
from maze import Maze
from pacman import PacMan
from ghost import Ghost


class GameScreen(Screen):
    """Game screen displayed in the game and selected from main menu."""

    # TODO move to its own file
    GHOST_COLORS = ("red", "green", "cyan", "pink")

    # colors used on game screen
    TITLE_COLOR = (255, 255, 255)

    def __init__(self, display: pygame.Surface, resources: Resources, maze: Maze) -> None:
        """Initialize the game screen."""
        super(GameScreen, self).__init__(display, resources)

        # fonts and other required resources are taken from resources object.
        self._pacman = PacMan(display, self._resources, "pacman")

        # TODO: refactoring for enum with ghost names/colors?
        self._ghosts = {
            "red" : Ghost(display, self._resources, "ghost_red"),
            "green" : Ghost(display, self._resources, "ghost_green"),
            "cyan" : Ghost(display, self._resources, "ghost_cyan"),
            "pink" : Ghost(display, self._resources, "ghost_pink"),
        }

        self._maze = maze
        self._clock = pygame.time.Clock()
        self._ghost_positions = maze.getGhostPositions()
        self._pacman_position = maze.getPacmanPosition()

    def draw(self) -> None:
        """Draw game screen."""
        self._display.fill(Colors.BLACK.value)
        self._maze.draw()

    def eventLoop(self) -> None:
        """Event loop for game screen."""
        while True:
            for event in pygame.event.get():
                if event.type == pygame.locals.QUIT:
                    pygame.quit()
                    sys.exit()
                if event.type == pygame.locals.KEYDOWN:
                    if event.key == pygame.locals.K_ESCAPE:
                        return
                    if event.key == pygame.locals.K_RETURN:
                        return

            # all events has been processed - redraw the screen
            self.draw()
            pygame.display.update()
            self._clock.tick(5)
