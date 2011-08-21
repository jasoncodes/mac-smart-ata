# Mac Pro SMART ATA Summary

A quick and dirty script to match report temperatures and reallocated sector counts for each ATA hard drive in your Mac Pro.

The reallocated sector count `Reallocated_Sector_Ct` SMART attribute is most useful for detecting a drive which is about to fail.
The temperature (`Temperature_Celsius`) is more for warm and fuzzies as the Mac Pro's temperature controls are quite good.

This script requires `smartmontools` which you can install via Homebrew with `brew install smartmontools`.
