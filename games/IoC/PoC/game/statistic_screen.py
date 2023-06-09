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
    VALUE_TITLE_COLOR = (130, 130, 130)
    VALUE_COLOR = (255, 255, 130)

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
        self._red_ghost.moveTo(100, 300)

        self._cyan_ghost = Ghost(display, self._resources, "ghost_cyan")
        self._cyan_ghost.moveTo(100, 363)

        self._green_ghost = Ghost(display, self._resources, "ghost_green")
        self._green_ghost.moveTo(100, 426)

        self._pink_ghost = Ghost(display, self._resources, "ghost_pink")
        self._pink_ghost.moveTo(100, 489)

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
        """Compute screen content for the next frame."""
        self._pacman.tick()
        self._red_ghost.cycleDirection()
        self._cyan_ghost.cycleDirection()
        self._green_ghost.cycleDirection()
        self._pink_ghost.cycleDirection()

    def drawSprites(self):
        """Draw all sprites onto the screen."""
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

        x = 250
        y = 105

        valueOffset = 200

        self.drawValueTitle(x, y, "Games:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.games}")
        y += 20

        self.drawValueTitle(x, y, "Total time:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.totalTime}")
        y += 20

        self.drawValueTitle(x, y, "Ghosts scared time:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.scaredTime}")

        y = 185

        self.drawValueTitle(x, y, "Small dots eaten:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.smallDotsEaten}")
        y += 23

        self.drawValueTitle(x, y, "Big dots eaten:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.largeDotsEaten}")
        y += 23

        self.drawValueTitle(x, y, "Ghosts eaten:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.pacmanKills}")
        y += 23

        self.drawValueTitle(x, y, "Mileage:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.pacmanMileage}")
        y += 40

        self.drawValueTitle(x, y, "Pacman overtakes:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.redGhostKills}")
        y += 23

        self.drawValueTitle(x, y, "Mileage:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.redGhostMileage}")
        y += 40

        self.drawValueTitle(x, y, "Pacman overtakes:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.cyanGhostKills}")
        y += 23

        self.drawValueTitle(x, y, "Mileage:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.cyanGhostMileage}")
        y += 40

        self.drawValueTitle(x, y, "Pacman overtakes:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.greenGhostKills}")
        y += 23

        self.drawValueTitle(x, y, "Mileage:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.greenGhostMileage}")
        y += 40

        self.drawValueTitle(x, y, "Pacman overtakes:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.pinkGhostKills}")
        y += 23

        self.drawValueTitle(x, y, "Mileage:")
        self.drawValue(x + valueOffset, y, f"{self._statistic.pinkGhostMileage}")

    def drawValue(self, x, y, string):
        """Draw given string with value on [x, y] coordinates."""
        rendered = self.renderString(string, StatisticScreen.VALUE_COLOR)
        self._display.blit(rendered, (x, y))

    def drawValueTitle(self, x, y, string):
        """Draw given string with value title on [x, y] coordinates."""
        rendered = self.renderString(string, StatisticScreen.VALUE_TITLE_COLOR)
        self._display.blit(rendered, (x, y))

    def drawString(self, x, y, string, color):
        """Draw given string on [x, y] coordinates."""
        rendered = self.renderString(string, color)
        self._display.blit(rendered, (x, y))

    def renderString(self, string, color):
        """Render given string onto new surface."""
        return self._resources.smallFont.render(string, True,
                                                color,
                                                StatisticScreen.BACKGROUND_COLOR)

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
