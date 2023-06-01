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

from abc import ABC
import pygame

from colors import Colors


class Screen(ABC):
    """Superclass for all screens in the game."""

    # colors used on screen
    BACKGROUND_COLOR = Colors.BLACK.value

    # default clock tick
    CLOCK_TICK = 5

    def __init__(self, display, resources):
        """Initialize the screen."""
        # primary display for blitting to screen
        self._display = display

        # all loaded resources
        self._resources = resources

        # clock to be used in event loop
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

            # and wait a bit
            self._clock.tick(Screen.CLOCK_TICK)
