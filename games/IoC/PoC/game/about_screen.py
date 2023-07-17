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

"""About screen displayed in the game and selected from the main menu."""

import sys
import pygame

from screen import Screen
from colors import Colors
from ghost import Ghost
from direction import Direction


class AboutScreen(Screen):
    """About screen displayed in the game."""

    # colors used on about screen
    TITLE_COLOR = (255, 255, 255)
    AUTHOR_COLOR = (120, 120, 255)
    WORK_COLOR = (120, 120, 120)

    def __init__(self, display, resources):
        """Initialize the about screen."""
        super(AboutScreen, self).__init__(display, resources)

        # fonts and other required resources are taken from resources object.

        # pre-render game title
        self._title = self._resources.bigFont.render("About", True,
                                                     AboutScreen.TITLE_COLOR,
                                                     AboutScreen.BACKGROUND_COLOR)

        # pre-render other texts
        self._author1 = self._resources.normalFont.render("Pavel", True,
                                                          AboutScreen.AUTHOR_COLOR,
                                                          AboutScreen.BACKGROUND_COLOR)
        self._author2 = self._resources.normalFont.render("Markétka", True,
                                                          AboutScreen.AUTHOR_COLOR,
                                                          AboutScreen.BACKGROUND_COLOR)

        self._work1 = self._resources.normalFont.render("code", True,
                                                        AboutScreen.WORK_COLOR,
                                                        AboutScreen.BACKGROUND_COLOR)
        self._work2 = self._resources.normalFont.render("gfx & sfx", True,
                                                        AboutScreen.WORK_COLOR,
                                                        AboutScreen.BACKGROUND_COLOR)

        # version info texts
        pygame_version = f"Pygame version: {pygame.version.ver}"
        self._pygame_version = self._resources.smallFont.render(pygame_version,
                                                                True,
                                                                AboutScreen.WORK_COLOR,
                                                                AboutScreen.BACKGROUND_COLOR)

        sdlVer = f"{pygame.version.SDL.major}.{pygame.version.SDL.minor}.{pygame.version.SDL.patch}"
        self._sdl_version = self._resources.smallFont.render("SDL version: " + sdlVer, True,
                                                             AboutScreen.WORK_COLOR,
                                                             AboutScreen.BACKGROUND_COLOR)
        pv = sys.version_info
        pythonVersion = f"{pv.major}.{pv.minor}.{pv.micro} {pv.releaselevel}"
        self._python_version = self._resources.smallFont.render("Python version: " + pythonVersion, True,
                                                            AboutScreen.WORK_COLOR,
                                                            AboutScreen.BACKGROUND_COLOR)

        self._clock = pygame.time.Clock()
        self._photo1 = self._resources.images["authors1"]
        self._photo2 = self._resources.images["authors2"]

        # pink ghost
        self._pink_ghost = Ghost(display, self._resources, "ghost_pink")
        self._pink_ghost.moveTo(600, 440)
        self._pink_ghost.setDirection(Direction.UP)

        # green ghost
        self._green_ghost = Ghost(display, self._resources, "ghost_green")
        self._green_ghost.moveTo(450, 600)
        self._green_ghost.setDirection(Direction.DOWN)

    def draw(self) -> None:
        """Draw about screen."""
        self._display.fill(Colors.BLACK.value)
        self.drawTitle()
        self.drawAuthors()
        self.drawTexts()
        self.drawVersionInfo()
        self.drawSprites()

    def drawSprites(self) -> None:
        """Draw all sprites onto the screen."""
        self._pink_ghost.draw()
        self._green_ghost.draw()

    def drawTitle(self) -> None:
        """Draw the title onto the about screen."""
        x = self._display.get_width() / 2 - self._title.get_width() / 2
        y = 0
        self._display.blit(self._title, (x, y))

    def drawAuthors(self) -> None:
        """Draw authors photos onto the screen."""
        self._display.blit(self._photo2, (100, 200))
        self._display.blit(self._photo1, (100, 350))

    def drawTexts(self) -> None:
        """Draw texts onto the screen."""
        self._display.blit(self._author2, (250, 190))
        self._display.blit(self._author1, (250, 340))
        self._display.blit(self._work1, (250, 380))
        self._display.blit(self._work2, (250, 230))

    def drawVersionInfo(self) -> None:
        """Draw info about library versions onto the screen."""
        x = 500
        y = 575
        step = 25
        self._display.blit(self._python_version, (x, y))
        self._display.blit(self._pygame_version, (x, y+step))
        self._display.blit(self._sdl_version, (x, y+step*2))

    def movePinkGhost(self) -> None:
        """Move the pink ghost."""
        STEP = 5
        LEFT = 40
        RIGHT = 210
        TOP = 100
        BOTTOM = 460

        self._pink_ghost.move(STEP)
        x, y = self._pink_ghost.getPosition()
        if y < TOP:
            self._pink_ghost.moveRel(0, STEP)
            self._pink_ghost.cycleDirection()
        elif y > BOTTOM:
            self._pink_ghost.moveRel(0, -STEP)
            self._pink_ghost.cycleDirection()
        elif x < LEFT:
            self._pink_ghost.moveRel(STEP, 0)
            self._pink_ghost.cycleDirection()
        elif x > RIGHT:
            self._pink_ghost.moveRel(-STEP, 0)
            self._pink_ghost.cycleDirection()

    def moveGreenGhost(self) -> None:
        """Move the green ghost."""
        STEP = 5
        LEFT = 40
        RIGHT = 550
        TOP = 160
        BOTTOM = 310

        self._green_ghost.move(STEP)
        x, y = self._green_ghost.getPosition()
        if y < TOP:
            self._green_ghost.moveRel(0, STEP)
            self._green_ghost.cycleDirection()
            self._green_ghost.cycleDirection()
            self._green_ghost.cycleDirection()
        elif y > BOTTOM:
            self._green_ghost.moveRel(0, -STEP)
            self._green_ghost.cycleDirection()
            self._green_ghost.cycleDirection()
            self._green_ghost.cycleDirection()
        elif x < LEFT:
            self._green_ghost.moveRel(STEP, 0)
            self._green_ghost.cycleDirection()
            self._green_ghost.cycleDirection()
            self._green_ghost.cycleDirection()
        elif x > RIGHT:
            self._green_ghost.moveRel(-STEP, 0)
            self._green_ghost.cycleDirection()
            self._green_ghost.cycleDirection()
            self._green_ghost.cycleDirection()

    def eventLoop(self) -> None:
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

            # all events has been processed - update scene and redraw the screen
            self.movePinkGhost()
            self.moveGreenGhost()
            self.draw()
            pygame.display.update()
            self._clock.tick(25)
