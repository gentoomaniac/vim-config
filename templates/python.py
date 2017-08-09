#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" Sample Script
    Version 0.2
"""

import argparse
import logging
import os
import sys

log = None

def setup_logger(
        name="samplescript",
        format="%(asctime)-15s %(name)-12s %(levelname)-8s %(message)s",
        level=logging.INFO):
    l = logging.getLogger(name)
    ch = logging.StreamHandler()
    ch.setFormatter(logging.Formatter(format))
    l.addHandler(ch)
    l.setLevel(level)
    return l


def set_loglevel(level):
    log.setLevel(getattr(logging, level))


def setup_argparse(description):
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('--loglevel', dest='loglevel', default="INFO", help='set logging level',
                        choices=[l for l in sorted(logging._levelNames.keys()) if isinstance(l, str)])
    return parser


def main():
    """ main program
    """
    global log
    log = setup_logger(name=os.path.basename(__file__))

    parser = setup_argparse("Sample script")
    args = parser.parse_args(sys.argv[1:])

    set_loglevel(args.loglevel)
    log.info('I am an informational log entry in the sample script.')


if __name__ == '__main__':
    main()
