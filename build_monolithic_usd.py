#!/usr/bin/env python3
import os
print("Cloning USD repository...")
os.system("git clone https://github.com/PixarAnimationStudios/USD .USD_build")
os.system("./patch_usd_build.sh")
print("Building a monolithic USD library...")
os.system("PATH=/Applications/CMake.app/Contents/bin:$PATH python3 .USD_build/build_scripts/build_usd.py --build-args TBB,extra_inc=big_iron.inc --no-python --no-tests --no-materialx --no-imaging --no-usdview --no-docs --build-monolithic USDMonolithic")
print("Done.")
