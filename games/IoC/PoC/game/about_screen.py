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

import pygame

from colors import Colors


class AboutScreen:
    BACKGROUND_COLOR = Colors.BLACK.value
    TITLE_COLOR = (255, 255, 255)
    STATISTIC_COLOR = (120, 120, 255)

    def __init__(self, display, resources):
        # pre-render game title
        self._title = resources.bigFont.render("About", True,
                                               AboutScreen.TITLE_COLOR,
                                               AboutScreen.BACKGROUND_COLOR)
        self._display = display
        self._clock = pygame.time.Clock()

    def draw(self):
        """Draw about screen."""
        self._display.fill(Colors.BLACK.value)
        self.drawTitle()

    def drawTitle(self):
        """Draw the title."""
        x = self._display.get_width() / 2 - self._title.get_width() / 2
        y = 0
        self._display.blit(self._title, (x, y))

    def eventLoop(self):
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

            self.draw()
            pygame.display.update()
            self._clock.tick(8)
