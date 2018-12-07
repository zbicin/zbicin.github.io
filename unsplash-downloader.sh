#!/bin/bash
function cropCover {
    quality=$1
    outDir=$2
    convert "$outDir/original.jpg" -resize 1920 -gravity Center -crop 1920x1024+0+0 -quality $quality "$outDir/cover-$quality.jpg"
}

function cropCoverSmall {
    quality=$1
    outDir=$2
    convert "$outDir/original.jpg" -resize 800 -gravity Center -crop 800x320+0+0 -quality $quality "$outDir/cover-small-$quality.jpg"
}

if [[ -z "$1" || -z "$2" ]]
  then
    echo "Invalid syntax."
    echo "Usage: ./unsplash-downloader photoId outDir"
    exit
fi

url="https://unsplash.com/photos/"$1"/download?force=true"
outDir=$2
echo $url
echo $outDir

echo "Downloading "$url
wget $url -O "$outDir/original.jpg" -nv

cropCover 80 $outDir
cropCover 70 $outDir
cropCover 60 $outDir
cropCover 50 $outDir

cropCoverSmall 80 $outDir
cropCoverSmall 70 $outDir
cropCoverSmall 60 $outDir
cropCoverSmall 50 $outDir