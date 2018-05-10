#!/bin/bash

find . -print0 | tar -czvf backup.tar.gz --null -T -
