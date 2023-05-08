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

from setup import IMAGES_PATH

import pygame
import os


class Ghost:
    def __init__(self, display, filename_prefix):
        self._display = display
        self._sprite = pygame.image.load(os.path.join(IMAGES_PATH, filename_prefix + "_left.png"))

    def draw(self):
        self._display.blit(self._sprite, (10, 10))
