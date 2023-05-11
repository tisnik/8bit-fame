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
        self._display = display

        self._frames = []
        for i in range(1, frames_count+1):
            filename = f"{filename_prefix}_{i}.png"
            frame = pygame.image.load(os.path.join(IMAGES_PATH, filename))
            self._frames.append(frame)

        self._frame = 0

        self._x = display.get_width() / 2 - self._frames[0].get_width() / 2
        self._y = 0

    def draw(self):
        self._display.blit(self._frames[self._frame], (self._x, self._y))
        self._frame += 1
        if self._frame >= len(self._frames):
            self._frame = 0
