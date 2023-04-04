@echo off
color 0a
cls
echo %PATH%
python -V
python -m pip install --upgrade RESTinstance
python -m pip install --upgrade robotframework-requests
python -m pip install --upgrade robotframework-datadriver
python -m pip install --upgrade robotframework-datadriver[XLS]
python -m pip install --upgrade robotframework-jsonlibrary
python -m pip install --upgrade robotframework-sshlibrary
pause