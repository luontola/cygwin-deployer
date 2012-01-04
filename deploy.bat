@echo off
jruby --1.9 lib/main.rb
echo.
del setup.log
del setup.log.full
