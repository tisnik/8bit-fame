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

import pygame
import os

from config import IMAGES_PATH

class Sprite:
    def draw(self):
        self._display.blit(self._sprites[self._direction], (10, 10))

    def loadImage(self, filename_prefix, filename_suffix):
        filename = f"{filename_prefix}_{filename_suffix}.png"
        return pygame.image.load(os.path.join(IMAGES_PATH, filename))