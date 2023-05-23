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

"""Settings screen displayed in the game and selected from main menu."""

import sys
import pygame

from screen import Screen
from colors import Colors


class SettingsScreen(Screen):
    """Settings screen displayed in the game and selected from main menu."""

    # colors used on settings screen
    TITLE_COLOR = (255, 255, 255)

    def __init__(self, display, resources):
        """Initialize the settings screen."""
        super(SettingsScreen, self).__init__(display, resources)

        # fonts and other required resources are taken from resources object.

        # pre-render game title
        self._title = self._resources.bigFont.render("Settings", True,
                                                     SettingsScreen.TITLE_COLOR,
                                                     SettingsScreen.BACKGROUND_COLOR)
        self._clock = pygame.time.Clock()

    def draw(self):
        """Draw settings screen."""
        self._display.fill(Colors.BLACK.value)
        self.drawTitle()

    def drawTitle(self):
        """Draw the title onto settings screen."""
        x = self._display.get_width() / 2 - self._title.get_width() / 2
        y = 0
        self._display.blit(self._title, (x, y))

    def eventLoop(self):
        """Event loop for settings screen that just waits for keypress or window close action."""
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
