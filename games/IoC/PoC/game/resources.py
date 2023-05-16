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


class Resources:
    FONT_FILE_NAME = "FreeSans.ttf"

    def __init__(self, configuration):
        self.loadFonts(configuration)

    def loadFonts(self, configuration):
        fontDirectory = configuration["paths"]["fonts"]
        fullFontFileName = os.path.join(fontDirectory, Resources.FONT_FILE_NAME)

        self._big_font = pygame.font.Font(fullFontFileName, 60)
        self._normal_font = pygame.font.Font(fullFontFileName, 40)
        self._small_font = pygame.font.Font(fullFontFileName, 20)

    @property
    def bigFont(self):
        return self._big_font

    @property
    def normalFont(self):
        return self._normal_font

    @property
    def smallFont(self):
        return self._small_font
