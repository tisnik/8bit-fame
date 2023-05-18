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

"""All entries from the main menu."""

from enum import Enum


class MainMenu(Enum):
    """All entries from the main menu."""

    NEW_GAME = 0
    SETTINGS = 1
    STATISTIC = 2
    ABOUT = 3
    QUIT = 4
