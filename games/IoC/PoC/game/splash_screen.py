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

import os
import pygame

from colors import Colors


class SplashScreen:
    """Splash screen with title, welcome animation, and a main menu."""
    CYCLE_DIRECTION_COUNTER_START_VALUE = 3
    BACKGROUND_COLOR = Colors.BLACK.value
    TITLE_COLOR = (255, 255, 255)
    MENU_COLOR = (120, 120, 255)

    # TODO: take from config
    FONT_FILE_NAME = "fonts/FreeSans.ttf"

    def __init__(self, display, images_path, filename_prefix, frames_count, ghost):
        # load fonts
        self._big_font = pygame.font.Font(SplashScreen.FONT_FILE_NAME, 60)
        self._normal_font = pygame.font.Font(SplashScreen.FONT_FILE_NAME, 40)
        self._small_font = pygame.font.Font(SplashScreen.FONT_FILE_NAME, 20)

        # pre-render game title
        self._title = self._big_font.render("Inversion of Control", True,
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

        # actually selected menu item
        self._selected_menu_item = 0

        self._display = display

        self._ghost = ghost
        self._cycleDirectionCounter = SplashScreen.CYCLE_DIRECTION_COUNTER_START_VALUE

        # load all animation frames
        self._frames = []
        for i in range(1, frames_count+1):
            filename = f"{filename_prefix}_{i}.png"
            frame = pygame.image.load(os.path.join(images_path, filename))
            self._frames.append(frame)

        self._frame = 0

    def renderMenuItem(self, text):
        return self._small_font.render(text, True,
                                       SplashScreen.MENU_COLOR,
                                       SplashScreen.BACKGROUND_COLOR)

    def draw(self):
        """Draw splash screen."""
        self.drawAnimation()
        self.drawTitle()
        self.drawMenu()
        self.drawGhost()

    def drawTitle(self):
        """Draw the title."""
        x = self._display.get_width() / 2 - self._title.get_width() / 2
        y = 0
        self._display.blit(self._title, (x, y))

    def drawAnimation(self):
        """Draw the welcome animation."""
        x = self._display.get_width() / 2 - self._frames[0].get_width() / 2 - 20
        y = 50
        self._display.blit(self._frames[self._frame], (x, y))
        self._frame += 1
        if self._frame >= len(self._frames):
            self._frame = 0

    def drawMenu(self):
        """Draw the main menu."""
        x = 100
        y = 300
        for menuItem in self._menu:
            self._display.blit(menuItem, (x, y))
            y += 50

    def drawGhost(self):
        """Draw the ghost on left side of main menu."""
        # compute ghost vertical position based on selected menu item
        y = 310 + self._selected_menu_item * 50
        self._ghost.setPosition(40, y)
        self._ghost.draw()
        self.cycleGhostDirection()

    def cycleGhostDirection(self):
        """Periodically change ghost direction to create simple animation."""
        self._cycleDirectionCounter -= 1
        if self._cycleDirectionCounter == 0:
            self._ghost.cycleDirection()
            self._cycleDirectionCounter = SplashScreen.CYCLE_DIRECTION_COUNTER_START_VALUE

    def moveGhostUp(self):
        """Move ghost up to previous menu item."""
        # previous item
        self._selected_menu_item -= 1

        # wrapping
        if self._selected_menu_item < 0:
            self._selected_menu_item = len(self._menu) - 1

        # redraw the screen immediatelly
        self.draw()

    def moveGhostDown(self):
        """Move ghost down to next menu item."""
        # next item
        self._selected_menu_item += 1

        # wrapping
        if self._selected_menu_item > len(self._menu) - 1:
            self._selected_menu_item = 0

        # redraw the screen immediatelly
        self.draw()

    def getSelectedMenuItem(self):
        """Retrieve actually selected menu item."""
        return self._selected_menu_item
