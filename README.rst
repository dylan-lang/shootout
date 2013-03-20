shootout
========

This directory holds the various source files necessary to run "The Computer
Language Benchmarks Game" previously known as the "Great Computer Language
Shootout."  You can find the required entries and rules at
http://benchmarksgame.alioth.debian.org/

Some benchmarks have been removed over time but are still maintained since
they may be of value for additional microbenchmarking.

In general, we want each example to be one file (if possible).


TODO
----

* ``fasta``, ``pidigits`` and ``spellcheck`` have to be converted from GD
  supported single-file format to a dual-file format compilable under
  OpenDylan.
* ``binary-trees``, ``fannkuch``, ``fasta``, ``fibonacci``, ``harmonic``,
  ``mandelbrot``, ``nestedloop``, ``strcat`` and ``takfp`` should provide a
  default command line argument value.
* ``nsieve`` provides an invalid default and should check for valid argument.
* ``nsieve`` and ``sieve`` benchmarks don't seem to work properly.
* ``fasta`` benchmark generates invalid output.
* ``k-nucleotide``, ``n-body``, ``spectralnorm`` and ``takfp`` benchmarks
  don't provide exactly expected output, due to lack of precision
  configuration support in the control-string of ``format-out``.
* ``moments`` benchmark doesn't work due to lack of support for ``string-to-float``.
* ``pidigits`` benchmark doesn't work due to lack of extended integer support.
* Many benchmarks can still be optimized.
