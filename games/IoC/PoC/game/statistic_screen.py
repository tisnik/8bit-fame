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

"""Statistic screen displayed in the game and selected from main menu."""

import sys
import pygame

from colors import Colors
from pacman import PacMan
from ghost import Ghost


class StatisticScreen:
    """Statistic screen displayed in the game and selected from main menu."""

    # colors used on statistic screen
    BACKGROUND_COLOR = Colors.BLACK.value
    TITLE_COLOR = (255, 255, 255)
    STATISTIC_COLOR = (120, 120, 255)

    def __init__(self, display, resources, statistic):
        """Initialize the statistic screen."""
        # fonts and other required resources are taken from resources object.

        # pre-render game title
        self._title = resources.bigFont.render("Statistic", True,
                                               StatisticScreen.TITLE_COLOR,
                                               StatisticScreen.BACKGROUND_COLOR)
        # pre-render base texts
        self._overall = resources.normalFont.render("Overall", True,
                                                    StatisticScreen.STATISTIC_COLOR,
                                                    StatisticScreen.BACKGROUND_COLOR)
        
        self._pacman = PacMan(display, resources, "pacman")
        self._pacman.moveTo(100, 200)

        self._red_ghost = Ghost(display, resources, "ghost_red")
        self._red_ghost.moveTo(100, 250)

        self._cyan_ghost = Ghost(display, resources, "ghost_cyan")
        self._cyan_ghost.moveTo(100, 300)

        self._green_ghost = Ghost(display, resources, "ghost_green")
        self._green_ghost.moveTo(100, 350)

        self._pink_ghost = Ghost(display, resources, "ghost_pink")
        self._pink_ghost.moveTo(100, 400)

        self._display = display
        self._clock = pygame.time.Clock()
        self._statistic = statistic

    def draw(self):
        """Draw statistic screen."""
        self._display.fill(Colors.BLACK.value)
        self.drawTitle()
        self.drawStatistic()
        self._pacman.draw()
        self._red_ghost.draw()
        self._cyan_ghost.draw()
        self._green_ghost.draw()
        self._pink_ghost.draw()

        self._pacman.tick()
        self._red_ghost.cycleDirection()
        self._cyan_ghost.cycleDirection()
        self._green_ghost.cycleDirection()
        self._pink_ghost.cycleDirection()

    def drawTitle(self):
        """Draw the title onto statistic screen."""
        x = self._display.get_width() / 2 - self._title.get_width() / 2
        y = 0
        self._display.blit(self._title, (x, y))

    def drawStatistic(self):
        """Draw statistic onto screen."""
        self._display.blit(self._overall, (100, 100))

    def eventLoop(self):
        """Event loop for Statistic screen that just waits for keypress or window close action."""
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
