#!/usr/bin/python
# @file    Board
# @author  David Zemon
#
# Created with: PyCharm Community Edition

"""
@description:
"""


class Board(object):
    def __init__(self):
        super().__init__()
        self._board = {}

    def set_living_cell(self, x, y):
        self._set_cell(x, y, Cell())

    def check_cell(self, x, y):
        return self._board[x][y]

    def _set_cell(self, x, y, cell):
        if x not in self._board:
            self._board[x] = {}

        self._board[x][y] = cell


class Cell(object):
    def __init__(self):
        super().__init__()
        self._living = True

    def living(self):
        return self._living

    def kill(self):
        self._living = False
