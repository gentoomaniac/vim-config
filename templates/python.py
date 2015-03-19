#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" Sample Script
    Version 0.1
"""

import logging

FORMAT = '%(asctime)-15s - %(message)s'
LOGGER = logging.getLogger('scriptlogger')
LOGGER.setLevel(logging.DEBUG)
ch = logging.StreamHandler()
ch.setFormatter(logging.Formatter(FORMAT))
LOGGER.addHandler(ch)

def main():
    """ main program
    """
    LOGGER.info('I am an informational log entry in the sample script.')

if __name__ == '__main__':
    main()
