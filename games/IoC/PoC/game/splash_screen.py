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

"""Splash screen with title, welcome animation, and a main menu."""

import pygame

from abstract_menu_screen import AbstractMenuScreen
from colors import Colors
from resources import Resources
from ghost import Ghost


class SplashScreen(AbstractMenuScreen):
    """Splash screen with title, welcome animation, and a main menu."""

    # colors used on splash screen (background color is read from Screen class
    CREDITS_COLOR = (140, 140, 140)

    def __init__(self, display: pygame.Surface, resources: Resources,
            filename_prefix: str, frames_count: int, ghost: Ghost) -> None:
        """Initialize the splash screen."""
        super(SplashScreen, self).__init__(display, resources, ghost)

        # fonts and other required resources are taken from resources object.

        # pre-render game title
        self._title = self._resources.bigFont.render("Inversion of Control", True,
                                                     SplashScreen.TITLE_COLOR,
                                                     SplashScreen.BACKGROUND_COLOR)

        # pre-render all menu items onto surfaces
        self._menu = (
            self.renderMenuItem("Start new game"),
            self.renderMenuItem("Settings"),
            self.renderMenuItem("Statistic"),
            self.renderMenuItem("About"),
            self.renderMenuItem("Quit"),
        )

        credits = "2023 Markétka Tišnovská, Pavel Tišnovský"
        self._credits = self._resources.smallFont.render(credits,
                                                         True,
                                                         SplashScreen.CREDITS_COLOR,
                                                         SplashScreen.BACKGROUND_COLOR)

        # retrieve all animation frames
        self._frames = []
        for i in range(1, frames_count+1):
            filename = f"{filename_prefix}_{i}"
            frame = self._resources.images[filename]
            self._frames.append(frame)

    def draw(self) -> None:
        """Draw splash screen."""
        self._display.fill(Colors.BLACK.value)
        self.drawAnimation()
        self.drawTitle()
        self.drawMenu()
        self.drawGhost()
        self.drawCredits()

    def drawAnimation(self) -> None:
        """Draw the welcome animation."""
        x = self._display.get_width() / 2 - self._frames[0].get_width() / 2 - 20
        y = 50
        self._display.blit(self._frames[self._frame], (x, y))
        self._frame += 1
        if self._frame >= len(self._frames):
            self._frame = 0

    def drawCredits(self) -> None:
        """Draw credits."""
        x = self._display.get_width() - self._credits.get_width() - 10
        y = self._display.get_height() - 30
        self._display.blit(self._credits, (x, y))
