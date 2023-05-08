from game import IMAGES_PATH

import pygame
import os


class Ghost:
    def __init__(self, display, filename_prefix):
        self._display = display
        self._sprite = pygame.image.load(os.path.join(IMAGES_PATH, filename_prefix + "_left.png"))

    def draw(self):
        self._display.blit(self._sprite, (10, 10))
