# Mac Pro SMART ATA Summary

A quick and dirty script to match report temperatures and reallocated sector counts for each ATA hard drive in your Mac Pro.

The reallocated sector count `Reallocated_Sector_Ct` SMART attribute is most useful for detecting a drive which is about to fail.
The temperature (`Temperature_Celsius`) is more for warm and fuzzies as the Mac Pro's temperature controls are quite good.

This script requires `smartmontools` which you can install via Homebrew with `brew install smartmontools`.

## Sample Output

    jason@graphite:~/mac-smart-ata (master)$ ruby mac-smart-ata.rb
    Bay 1 (disk3): 43°C, 6 sector reallocations
    Bay 2 (disk2): 40°C, 14 sector reallocations
    Bay 3 (disk4): 42°C, 1267 sector reallocations
    Bay 4 (disk1): 47°C, 2 sector reallocations

Uh oh. It looks like I've got a [Deathstar](http://en.wikipedia.org/wiki/IBM_Deathstar) which is about to explode.