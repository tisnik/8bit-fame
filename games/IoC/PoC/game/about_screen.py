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

"""About screen displayed in the game and selected from the main menu."""

import sys
import pygame

from colors import Colors


class AboutScreen:
    """About screen displayed in the game."""

    # colors used on about screen
    BACKGROUND_COLOR = Colors.BLACK.value
    TITLE_COLOR = (255, 255, 255)
    AUTHOR_COLOR = (120, 120, 255)
    WORK_COLOR = (120, 120, 120)

    def __init__(self, display, resources):
        """Initialize the about screen."""
        # fonts and other required resources are taken from resources object.

        # pre-render game title
        self._title = resources.bigFont.render("About", True,
                                               AboutScreen.TITLE_COLOR,
                                               AboutScreen.BACKGROUND_COLOR)

        # pre-render other texts
        self._author1 = resources.normalFont.render("Pavel", True,
                                                    AboutScreen.AUTHOR_COLOR,
                                                    AboutScreen.BACKGROUND_COLOR)
        self._author2 = resources.normalFont.render("Markétka", True,
                                                    AboutScreen.AUTHOR_COLOR,
                                                    AboutScreen.BACKGROUND_COLOR)

        self._work1 = resources.normalFont.render("code", True,
                                                  AboutScreen.WORK_COLOR,
                                                  AboutScreen.BACKGROUND_COLOR)
        self._work2 = resources.normalFont.render("gfx & sfx", True,
                                                  AboutScreen.WORK_COLOR,
                                                  AboutScreen.BACKGROUND_COLOR)

        self._display = display
        self._clock = pygame.time.Clock()
        self._photo1 = resources.images["authors1"]
        self._photo2 = resources.images["authors2"]

    def draw(self):
        """Draw about screen."""
        self._display.fill(Colors.BLACK.value)
        self.drawTitle()
        self.drawAuthors()
        self.drawTexts()

    def drawTitle(self):
        """Draw the title onto the about screen."""
        x = self._display.get_width() / 2 - self._title.get_width() / 2
        y = 0
        self._display.blit(self._title, (x, y))

    def drawAuthors(self):
        """Draw authors photos onto the screen."""
        self._display.blit(self._photo2, (100, 200))
        self._display.blit(self._photo1, (100, 350))

    def drawTexts(self):
        """Draw texts onto the screen."""
        self._display.blit(self._author2, (250, 190))
        self._display.blit(self._author1, (250, 340))
        self._display.blit(self._work1, (250, 380))
        self._display.blit(self._work2, (250, 230))

    def eventLoop(self):
        """Event loop for About screen that just waits for keypress or window close operation."""
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
            self._clock.tick(8)
