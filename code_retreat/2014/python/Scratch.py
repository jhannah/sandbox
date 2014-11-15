#!/usr/bin/python
# @file    Scratch
# @author  David Zemon
#
# Created with: PyCharm Community Edition

"""
@description:
"""

import unittest

import Conways


class MyTest(unittest.TestCase):
    def setUp(self):
        self._board = Conways.Board()

    def test_board_constructor(self):
        cell = Conways.Cell()

    def test_cell_default_constructor(self):
        cell = Conways.Cell()
        self.assertTrue(cell.living())

    def test_cell_can_be_killed(self):
        cell = Conways.Cell()
        cell.kill()
        self.assertFalse(cell.living())

    def test_place_cell_on_board(self):
        self._board.set_living_cell(3, 3)
        self.assertTrue(self._board.check_cell(3, 3).living())

    def test_can_kill_cell_on_board(self):
        pass


if '__main__' == __name__:
    unittest.main()
