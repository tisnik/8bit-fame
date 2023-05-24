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

from screen import Screen
from colors import Colors
from pacman import PacMan
from ghost import Ghost


class StatisticScreen(Screen):
    """Statistic screen displayed in the game and selected from main menu."""

    # colors used on statistic screen
    TITLE_COLOR = (255, 255, 255)
    STATISTIC_COLOR = (120, 120, 255)

    def __init__(self, display, resources, statistic):
        """Initialize the statistic screen."""
        super(StatisticScreen, self).__init__(display, resources)

        # fonts and other required resources are taken from resources object.

        # pre-render game title
        self._title = self._resources.bigFont.render("Statistic", True,
                                                     StatisticScreen.TITLE_COLOR,
                                                     StatisticScreen.BACKGROUND_COLOR)
        # pre-render base texts
        self._overall = self._resources.normalFont.render("Overall", True,
                                                          StatisticScreen.STATISTIC_COLOR,
                                                          StatisticScreen.BACKGROUND_COLOR)
        
        self._pacman = PacMan(display, self._resources, "pacman")
        self._pacman.moveTo(100, 200)

        self._red_ghost = Ghost(display, self._resources, "ghost_red")
        self._red_ghost.moveTo(100, 250)

        self._cyan_ghost = Ghost(display, self._resources, "ghost_cyan")
        self._cyan_ghost.moveTo(100, 300)

        self._green_ghost = Ghost(display, self._resources, "ghost_green")
        self._green_ghost.moveTo(100, 350)

        self._pink_ghost = Ghost(display, self._resources, "ghost_pink")
        self._pink_ghost.moveTo(100, 400)

        self._clock = pygame.time.Clock()
        self._statistic = statistic

    def draw(self):
        """Draw statistic screen."""
        self._display.fill(Colors.BLACK.value)
        self.drawTitle()
        self.drawSprites()
        self.drawStatistic()
        self.nextFrame()

    def nextFrame(self):
        self._pacman.tick()
        self._red_ghost.cycleDirection()
        self._cyan_ghost.cycleDirection()
        self._green_ghost.cycleDirection()
        self._pink_ghost.cycleDirection()

    def drawSprites(self):
        self._pacman.draw()
        self._red_ghost.draw()
        self._cyan_ghost.draw()
        self._green_ghost.draw()
        self._pink_ghost.draw()

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
