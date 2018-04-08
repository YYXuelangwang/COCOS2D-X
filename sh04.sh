

funWithParam(){

	cd $1

	list=$(ls | grep '\.png')

	for data in ${list[@]}
	do
		echo ${data}
		read -p "input the new filename:" filePart
		exo=".png"
		fileName=${filePart}${exo}
		if [ "$filePart" == "" ]; then
			fileName=${data}
		fi
		path="/Users/yinyong/work/tempPhotos/"
		filePath=${path}${fileName}
		mv -i ${data} ${filePath} 

	done
	if [ "$2" == "" ]; then
		cd ..
	fi
}

diGui(){

	echo $1
	cd $1

	list2=$(ls)

	for data1 in ${list2[@]}
	do
		if test -d ${data1}
		then
			echo "change workdir ${data1}"
			funWithParam ${data1}
			diGui ${data1}
		fi
	done

}

first="./"

funWithParam ${first} one
diGui ${first}

echo $lis
