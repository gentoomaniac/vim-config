#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import syslog

class Debug:

    def __init__(self, dlvl):
        self.level = dlvl

    def setLvl(self, dlvl):
        self.level = dlvl

    def stdout(self, dstr, dlvl=1):
        if dlvl <= self.level:
            print dstr

    def syslog(self, dstr, dlvl=1):
        if dlvl <= self.level:
            syslog.syslog('%s: %s' % (sys.argv[0], dstr.replace('\n', ' ')))

def main():
    debug = Debug(10)
    debug.stdout('Debug string',1)

if __name__ == '__main__':
    main()
