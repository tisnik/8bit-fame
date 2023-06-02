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

"""Games statistic."""

from os.path import exists
import pickle

STATISTIC_FILENAME = "ioc.stats"


class Statistic:
    """Games statistic."""

    def __init__(self):
        """Statistic initialization."""
        self.games = 0
        self.totalTime = 0
        self.scaredTime = 0
        self.smallDotsEaten = 0
        self.largeDotsEaten = 0
        self.pacmanKills = 0
        self.cyanGhostKills = 0
        self.greenGhostKills = 0
        self.pinkGhostKills = 0
        self.redGhostKills = 0

    @staticmethod
    def load():
        """Load statistic from binary file."""
        with open(STATISTIC_FILENAME, "rb") as fin:
            return pickle.load(fin)

    def save(self):
        """Save statistic into binary file."""
        with open(STATISTIC_FILENAME, "wb") as fout:
            pickle.dump(self, fout)

    def exists(self):
        """Check if file with statistic exists."""
        return exists(STATISTIC_FILENAME)
