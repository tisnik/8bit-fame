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

from config import IMAGES_PATH


class SplashScreen:
    def __init__(self, display, filename_prefix, frames_count):
        self._big_font = pygame.font.Font("fonts/FreeSans.ttf", 60)
        self._small_font = pygame.font.Font("fonts/FreeSans.ttf", 40)
        self._title = self._big_font.render("Inversion of Control", True, (255,255,255), (0,0,0))

        self._menu = (
            self._small_font.render("Start new game", True, (120,120,255), (0,0,0)),
            self._small_font.render("Settings", True, (120,120,255), (0,0,0)),
            self._small_font.render("Statistic", True, (120,120,255), (0,0,0)),
            self._small_font.render("Quit", True, (120,120,255), (0,0,0)),
        )

        self._display = display

        self._frames = []
        for i in range(1, frames_count+1):
            filename = f"{filename_prefix}_{i}.png"
            frame = pygame.image.load(os.path.join(IMAGES_PATH, filename))
            self._frames.append(frame)

        self._frame = 0


    def draw(self):
        self.drawAnimation()
        self.drawTitle()
        self.drawMenu()


    def drawTitle(self):
        x = self._display.get_width() / 2 - self._title.get_width() / 2
        y = 0
        self._display.blit(self._title, (x, y))


    def drawAnimation(self):
        x = self._display.get_width() / 2 - self._frames[0].get_width() / 2 - 20
        y = 50
        self._display.blit(self._frames[self._frame], (x, y))
        self._frame += 1
        if self._frame >= len(self._frames):
            self._frame = 0


    def drawMenu(self):
        x = 100
        y = 300
        for menuItem in self._menu:
            self._display.blit(menuItem, (x, y))
            y += 50
