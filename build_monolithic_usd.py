#!/usr/bin/env python
import os
print("Cloning USD repository...")
os.system("git clone https://github.com/PixarAnimationStudios/USD .USD_build")
print("Building a monolithic USD library...")
os.system("python .USD_build/build_scripts/build_usd.py --build-args TBB,extra_inc=big_iron.inc --no-python --no-tests --no-materialx --no-imaging --no-usdview --no-docs --build-monolithic USDMonolithic")
print("Done.")
