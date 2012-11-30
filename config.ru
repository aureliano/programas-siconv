#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require 'dm-mongodb-adapter'
require File.expand_path("../config/boot.rb", __FILE__)

run Padrino.application
