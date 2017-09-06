#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" Sample Script
    Version 0.2.1
"""

import argparse
import logging
import sys

log = None

def setup_logger(
        name="global",
        format="%(asctime)-15s %(filename)s:%(lineno)s %(funcName)20s() %(levelname)-8s - %(message)s",
        level=logging.DEBUG):
    l = logging.getLogger(name)
    ch = logging.StreamHandler()
    ch.setFormatter(logging.Formatter(format))
    l.addHandler(ch)
    l.setLevel(level)
    return l


def set_loglevel(logger, level):
    logger.setLevel(getattr(logging, level))


def setup_argparse(description):
    log.debug("Setting up argparse ...")
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('--loglevel', dest='loglevel', default="INFO", help='set logging level',
                        choices=[l for l in sorted(logging._levelNames.keys()) if isinstance(l, str)])
    return parser


def main():
    """ main program
    """
    global log
    log = setup_logger()

    parser = setup_argparse("Sample script")
    args = parser.parse_args(sys.argv[1:])

    set_loglevel(log, args.loglevel)
    log.info('I am an informational log entry in the sample script.')


if __name__ == '__main__':
    main()
