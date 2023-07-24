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

"""Resources used within the game."""

import os
import configparser

from typing import List, Tuple

import pygame
from os.path import isfile, join


class Resources:
    """Resources used within the game."""

    FONT_FILE_NAME = "FreeSans.ttf"

    def __init__(self, configuration: configparser.ConfigParser) -> None:
        """Resource initialization."""
        self.loadFonts(configuration)
        self.loadImages(configuration)

    def loadFonts(self, configuration: configparser.ConfigParser) -> None:
        """Load all required fonts."""
        fontDirectory = configuration["paths"]["fonts"]
        fullFontFileName = os.path.join(fontDirectory, Resources.FONT_FILE_NAME)

        self._big_font = pygame.font.Font(fullFontFileName, 60)
        self._normal_font = pygame.font.Font(fullFontFileName, 40)
        self._small_font = pygame.font.Font(fullFontFileName, 20)

    def loadImages(self, configuration: configparser.ConfigParser) -> None:
        """Load all images from specified directory."""
        imageList = get_list_of_images(configuration)
        self._images = {}
        for imageName in imageList:
            self._images[imageName[0]] = pygame.image.load(imageName[1])

    @property
    def bigFont(self):
        """Big font to be used on all screens."""
        return self._big_font

    @property
    def normalFont(self):
        """Middle font to be used on all screens."""
        return self._normal_font

    @property
    def smallFont(self):
        """Small font to be used on all screens."""
        return self._small_font

    @property
    def images(self):
        """All images available as list."""
        return self._images


def get_list_of_images(configuration: configparser.ConfigParser) -> List[Tuple[str, str]]:
    """Retrieve list of all image files from specified directory."""
    path = configuration["paths"]["images"]
    return [(short_filename(fileName), join(path, fileName))
            for fileName in os.listdir(path) if isfile(join(path, fileName))]


def short_filename(filename: str) -> str:
    """Take just filename without extension."""
    return filename[0:filename.index(".")]
