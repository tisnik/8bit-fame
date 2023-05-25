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

from screen import Screen
from colors import Colors
from main_menu import MainMenu


class SplashScreen(Screen):
    """Splash screen with title, welcome animation, and a main menu."""

    CYCLE_DIRECTION_COUNTER_START_VALUE = 3

    # colors used on splash screen (background color is read from Screen class
    TITLE_COLOR = (255, 255, 255)
    MENU_COLOR = (120, 120, 255)
    CREDITS_COLOR = (140, 140, 140)

    def __init__(self, display, resources, filename_prefix, frames_count, ghost):
        """Initialize the splash screen."""
        super(SplashScreen, self).__init__(display, resources)

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

        # actually selected menu item
        self._selected_menu_item = 0

        credits = "2023 Markétka Tišnovská, Pavel Tišnovský"
        self._credits = self._resources.smallFont.render(credits,
                                                         True,
                                                         SplashScreen.CREDITS_COLOR,
                                                         SplashScreen.BACKGROUND_COLOR)

        self._ghost = ghost
        self._cycleDirectionCounter = SplashScreen.CYCLE_DIRECTION_COUNTER_START_VALUE

        # retrieve all animation frames
        self._frames = []
        for i in range(1, frames_count+1):
            filename = f"{filename_prefix}_{i}"
            frame = self._resources.images[filename]
            self._frames.append(frame)

        self._frame = 0

        self._clock = pygame.time.Clock()

    def renderMenuItem(self, text):
        """Render one menu item to be displayed on splash screen."""
        return self._resources.normalFont.render(text, True,
                                                 SplashScreen.MENU_COLOR,
                                                 SplashScreen.BACKGROUND_COLOR)

    def draw(self):
        """Draw splash screen."""
        self._display.fill(Colors.BLACK.value)
        self.drawAnimation()
        self.drawTitle()
        self.drawMenu()
        self.drawGhost()
        self.drawCredits()

    def drawTitle(self):
        """Draw the title onto splash screen."""
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

    def drawCredits(self):
        """Draw credits."""
        x = self._display.get_width() - self._credits.get_width() - 10
        y = self._display.get_height() - 30
        self._display.blit(self._credits, (x, y))

    def eventLoop(self):
        """Event loop for splash screen that just waits for keypress or window close action."""
        while True:
            for event in pygame.event.get():
                if event.type == pygame.locals.QUIT:
                    pygame.quit()
                    sys.exit()
                if event.type == pygame.locals.KEYDOWN:
                    if event.key == pygame.locals.K_ESCAPE:
                        return MainMenu.QUIT.value
                    elif event.key == pygame.locals.K_UP:
                        self.moveGhostUp()
                    elif event.key == pygame.locals.K_DOWN:
                        self.moveGhostDown()
                    elif event.key == pygame.locals.K_RETURN:
                        return self.getSelectedMenuItem()
                    elif event.key == pygame.locals.K_a:
                        return MainMenu.ABOUT.value
                    elif event.key == pygame.locals.K_q:
                        return MainMenu.QUIT.value

            # all events has been processed - redraw the screen
            self.draw()
            pygame.display.update()
            self._clock.tick(8)
