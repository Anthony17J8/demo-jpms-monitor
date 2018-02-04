@echo off
echo "--- COMPILATION & PACKAGING ---"

echo " > creating clean directories"
del /s /q classes
rmdir /s /q classes
mkdir classes
del /s /q mods
rmdir /s /q mods
mkdir mods

echo " > creating monitor.observer"
dir /S /B monitor.observer\src\*.java > sources.txt
javac -d classes/monitor.observer @sources.txt
del sources.txt
jar --create --file mods/monitor.observer.jar -C classes/monitor.observer .

echo " > creating monitor.observer.alpha"
dir /S /B monitor.observer.alpha\src\*.java > sources.txt
javac --module-path mods -d classes/monitor.observer.alpha @sources.txt
del sources.txt
jar --create --file mods/monitor.observer.alpha.jar -C classes/monitor.observer.alpha .

echo " > creating monitor.observer.beta"
dir /S /B monitor.observer.beta\src\*.java > sources.txt
javac --module-path mods -d classes/monitor.observer.beta @sources.txt
del sources.txt
jar --create --file mods/monitor.observer.beta.jar -C classes/monitor.observer.beta .

echo " > creating monitor.observer.zero (plain JAR)"
set JARS=
for %%f in (mods\*.jar) do call set JARS=%%JARS%%;"%%f"
dir /S /B monitor.observer.zero\src\*.java > sources.txt
javac --class-path %JARS% -d classes/monitor.observer.zero @sources.txt
xcopy monitor.observer.zero\src\main\resources classes\monitor.observer.zero /e
del sources.txt
jar --create --file mods/monitor.observer.zero.jar -C classes/monitor.observer.zero .

echo " > creating monitor.statistics"
dir /S /B monitor.statistics\src\*.java > sources.txt
javac --module-path mods -d classes/monitor.statistics @sources.txt
del sources.txt
jar --create --file mods/monitor.statistics.jar -C classes/monitor.statistics .

echo " > creating monitor.persistence"
dir /S /B monitor.persistence\src\*.java > sources.txt
javac --module-path mods -d classes/monitor.persistence @sources.txt
del sources.txt
jar --create --file mods/monitor.persistence.jar -C classes/monitor.persistence .

echo " > creating monitor.rest"
dir /S /B monitor.rest\src\*.java > sources.txt
javac --module-path mods -d classes/monitor.rest @sources.txt
del sources.txt
jar --create --file mods/monitor.rest.jar -C classes/monitor.rest .

echo " > creating monitor"
dir /S /B monitor\src\*.java > sources.txt
javac --module-path mods -d classes/monitor @sources.txt
del sources.txt
jar --create --file mods/monitor.jar --main-class monitor.Main -C classes/monitor .
