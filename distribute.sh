#!/bin/bash
#
# CHANGE THIS FOR BEOS, CYGWIN, ETC!
if [ $MSYSTEM = MINGW32 ]
  then
  simexe=.exe
  simarchiv=simuwin
  echo "Windows"
  updatepath="/nsis/"
  updater="download-paksets.exe"
  else
  simexe=
  simarchiv=simulinux
  updatepath="/"
  updater="get_pak.sh"
  echo "Linux"
fi



# (otherwise there will be many .svn included under windows)
distribute()
{
	# pack all files of the current release
	FILELISTE=`find simutrans -type f "(" -name "*.tab" -o -name "*.mid" -o -name "*.bdf" -o -name "*.fnt" -o -name "*.txt"  -o -name "*.dll"  -o -name "*.pak" -o  -name "*.nut" ")"`
	zip -9 $simarchiv.zip $FILELISTE simutrans/simutrans$simexe simutrans/$updater
}

# fetch language files
sh ./get_lang_files.sh

# now built the archive for distribution
cd simutrans
cp ../sim$simexe ./simutrans$simexe
strip simutrans$simexe
cp ..$updatepath$updater $updater
cd ..
distribute

# .. finally delete executable and language files
rm simutrans/simutrans$simexe
#rm simutrans/text/*.tab
