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

"""Superclass for all screens in the game."""

import pygame

from colors import Colors


class Screen:
    """Superclass for all screens in the game."""

    # colors used on screen
    BACKGROUND_COLOR = Colors.BLACK.value

    def __init__(self, display):
        """Initialize the screen."""
        self._display = display
        self._clock = pygame.time.Clock()

    def draw(self):
        """Draw screen."""
        # this method should be overwritten
        self._display.fill(BACKGROUND_COLOR)

    def eventLoop(self):
        """Event loop."""
        # this method should be overwritten
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