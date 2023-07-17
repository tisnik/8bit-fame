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

from abstract_menu_screen import AbstractMenuScreen
from colors import Colors
from resources import Resources
from ghost import Ghost


class SettingsScreen(AbstractMenuScreen):
    """Settings screen displayed in the game and selected from main menu."""

    CYCLE_DIRECTION_COUNTER_START_VALUE = 3

    # colors used on settings screen
    TITLE_COLOR = (255, 255, 255)
    MENU_COLOR = (120, 120, 255)

    def __init__(self, display: pygame.Surface, resources: Resources, ghost: Ghost) -> None:
        """Initialize the settings screen."""
        super(SettingsScreen, self).__init__(display, resources, ghost)

        # fonts and other required resources are taken from resources object.

        # pre-render game title
        self._title = self._resources.bigFont.render("Settings", True,
                                                     SettingsScreen.TITLE_COLOR,
                                                     SettingsScreen.BACKGROUND_COLOR)
        # pre-render all menu items onto surfaces
        self._menu = (
            self.renderMenuItem("Maze"),
            self.renderMenuItem("Game rules"),
            self.renderMenuItem("Controls"),
            self.renderMenuItem("Return to main screen"),
        )

        self._clock = pygame.time.Clock()

    def draw(self) -> None:
        """Draw settings screen."""
        self._display.fill(Colors.BLACK.value)
        self.drawTitle()
        self.drawMenu()
        self.drawGhost()
