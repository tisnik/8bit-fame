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

import pickle

STATISTIC_FILENAME = "ioc.stats"


class Statistic:
    def __init__(self):
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


def loadStatistic():
    with open(STATISTIC_FILENAME, "rb") as fin:
        return pickle.load(fin)


def saveStatistic(statistic):
    with open(STATISTIC_FILENAME, "wb") as fout:
        pickle.dump(statistic,fout)
