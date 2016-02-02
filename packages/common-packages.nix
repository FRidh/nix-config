{ pkgs, pythonPackages }:

with pythonPackages; [
    blaze
    bottleneck
    cython
    cytoolz
    dill
#    jupyter
    line_profiler
    matplotlib
    memory_profiler
    nose
    notebook
    numba
    numexpr
    numpy
    numtraits
    odo
    pandas
    pyaudio
    pyfftw
#    pyqt4
#    pytest
#    qtconsole
    #scikitlearn
    scipy 
    seaborn 
    setuptools
#    sounddevice
    sphinx
    statsmodels
    toolz
#    xarray
  ]
