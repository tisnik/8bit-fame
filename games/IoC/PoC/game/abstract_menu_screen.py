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

"""Any screen with menu."""

import pygame

from screen import Screen


class AbstractMenuScreen(Screen):
    """Splash screen with title, welcome animation, and a main menu."""

    CYCLE_DIRECTION_COUNTER_START_VALUE = 3

    # colors used on menu screen (background color is read from Screen class
    TITLE_COLOR = (255, 255, 255)
    MENU_COLOR = (120, 120, 255)

    def __init__(self, display, resources, ghost):
        """Initialize the splash screen."""
        super(AbstractMenuScreen, self).__init__(display, resources)
        self._ghost = ghost
        self._cycleDirectionCounter = AbstractMenuScreen.CYCLE_DIRECTION_COUNTER_START_VALUE

        self._frame = 0

        self._clock = pygame.time.Clock()

    def renderMenuItem(self, text):
        """Render one menu item to be displayed on splash screen."""
        return self._resources.normalFont.render(text, True,
                                                 AbstractMenuScreen.MENU_COLOR,
                                                 AbstractMenuScreen.BACKGROUND_COLOR)

    def drawTitle(self):
        """Draw the title onto splash screen."""
        x = self._display.get_width() / 2 - self._title.get_width() / 2
        y = 0
        self._display.blit(self._title, (x, y))

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
            self._cycleDirectionCounter = AbstractMenuScreen.CYCLE_DIRECTION_COUNTER_START_VALUE

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