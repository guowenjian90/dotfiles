. "$HOME/.cargo/env"

  # --header-lines=1 \
export FM_CMD="rm /tmp/fm.dir.yank; rm /tmp/fm.dir.cut; rm /tmp/fm.dir; touch /tmp/fm.dir.yank; touch /tmp/fm.dir.cut; fm_cd_dir .; fm_ls_dir" 
alias fm="$FM_CMD | fzf --multi\
  --preview='fm_preview_file {}' \
  --header 'c-l: reload, c-t: search dir, c-f: search file, c-n: new, c-c: copy, c-d: delete, c-r: rename, c-o: edit, c-y: toggle yank, c-x: toggle cut, c-p: paste yank/cut list here, c-v: preview yank/cut list' \
  --layout=reverse \
  --preview-window=right:60% \
  --bind 'ctrl-/:toggle-preview' \
  --bind 'space:toggle' \
  --bind 'ctrl-l:execute(rm /tmp/fm.search.result)+reload(fm_ls_dir)' \
  --bind 'ctrl-o:execute(vim {})+reload(fm_ls_dir)' \
  --bind 'ctrl-n:execute(fm_new_file)+reload(fm_ls_dir)' \
  --bind 'ctrl-d:execute(fm_rm_file {})+reload(fm_ls_dir)' \
  --bind 'ctrl-r:execute(fm_mv_file {})+reload(fm_ls_dir)' \
  --bind 'ctrl-c:execute(fm_cp_file {})+reload(fm_ls_dir)' \
  --bind 'ctrl-y:execute-multi(fm_yank_files {})+reload(fm_ls_dir)' \
  --bind 'ctrl-x:execute-multi(fm_cut_files {})+reload(fm_ls_dir)' \
  --bind 'ctrl-p:execute(fm_paste_file)+reload(fm_ls_dir)' \
  --bind 'ctrl-t:execute(fm_search_dir)+reload(fm_show_search)' \
  --bind 'ctrl-f:execute(fm_search_file)+reload(fm_show_search)' \
  --bind 'ctrl-v:execute(fm_show_yank_cut_list)+reload(fm_show_search)' \
  --bind 'left:execute(fm_cd_dir ..)+reload(fm_ls_dir)+clear-query' \
  --bind 'right:execute(fm_cd_dir {})+reload(fm_ls_dir)+clear-query' \
  --bind 'enter:execute(fm_cd_dir {})+reload(fm_ls_dir)+clear-query' \
"

fm_ls_dir() {
  dirfile="/tmp/fm.dir"
  if [ -e $dirfile ]; then 
    dir=$(<"$dirfile")
  else
    dir=$(pwd)
  fi
  search_file="/tmp/fm.search.result"
  if [ -e $search_file ]; then 
    fm_show_search
  else
    file_list='/tmp/fm.dir.list'
   `ls -A -1 $dir > $file_list`
    fm_append_cut_yank_flag $file_list
  fi
}

fm_append_cut_yank_flag() {
  files=()
  while IFS= read -r line; do
    files+=("$line")
  done < $1
  dirfile="/tmp/fm.dir"
  if [ -e $dirfile ]; then 
    dir=$(<"$dirfile")
  else
    dir=$(pwd)
  fi
  cut_files=()
  while IFS= read -r line; do
    cut_files+=("$line")
  done < "/tmp/fm.dir.cut"
  yank_files=()
  while IFS= read -r line; do
    yank_files+=("$line")
  done < "/tmp/fm.dir.yank"
  if [ -z "${files[@]}" ]; then
    echo ""
  else
    for file in "${files[@]}"; do
      nfile=$file
      if [[ $file =~ ^/ ]]; then
      else
        file="$dir/$file"
      fi
      if [[ -d $file ]]; then 
        nfile="$nfile/"
      else
        nfile="$nfile"
      fi
      for c in "${cut_files[@]}"; do
        if [ "$file" = "$c" ] || [ "$nfile" = $c ]; then
          nfile="$nfile(cutted)"
          break
        fi
      done
      for c in "${yank_files[@]}"; do
        if [ "$file" = "$c" ] || [ "$nfile" = $c ]; then
          nfile="$nfile(yanked)"
          break
        fi
      done
      echo $nfile
    done
  fi
}

fm_search_dir() {
  file="/tmp/fm.dir"
  if [ -e $file ]; then
    dir=$(<"$file")
  else
    dir=$(pwd)
  fi
  echo "search child directories from $dir, pattern:"
  read pattern
  file="/tmp/fm.search.result"
  if [ -e $file ]; then
    rm $file
  fi
  find . -type d -print | ag $pattern | while read -r f; do
    echo `realpath $f` >> $file
  done
}

fm_search_file() {
  file="/tmp/fm.dir"
  if [ -e $file ]; then
    dir=$(<"$file")
  else
    dir=$(pwd)
  fi
  echo "search files from $dir, pattern:"
  read pattern
  file="/tmp/fm.search.result"
  if [ -e $file ]; then
    rm $file
  fi
  ag --hidden -l --path-to-ignore ~/.ignore --nocolor -g $pattern $dir | while read -r f; do
    echo `realpath $f` >> $file
  done
}

fm_show_yank_cut_list() {
  file="/tmp/fm.search.result"
  if [ -e $file ]; then
    rm $file
  fi
  if [ -e "/tmp/fm.dir.cut" ]; then
    cat "/tmp/fm.dir.cut" >> $file
  fi
  if [ -e "/tmp/fm.dir.yank" ]; then
    cat "/tmp/fm.dir.yank" >> $file
  fi
}

fm_show_search() {
  files="/tmp/fm.search.result"
  fm_append_cut_yank_flag $files
}

fm_preview_file() {
  GREEN='\033[0;32m'
  NC='\033[0m' # No Color
  file="/tmp/fm.dir"
  if [ -e $file ]; then
    dir=$(<"$file")
  else
    dir=$(pwd)
  fi
  echo -e "${GREEN}$dir\n"
  if [ -z $1 ]; then
    dest=$dir
  else
    dest="$dir/$1"
  fi
  dest=${dest%\(cutted\)}
  dest=${dest%\(yanked\)}
  if [ -d $dest ]; then (tree -a -C -L 3 $dest) else (ls -l $dest; batcat -m "*.scala:Kotlin" --color=always $dest) fi
}

fm_cd_dir() {
  if [ -z $1 ]; then
    return
  fi
  file="/tmp/fm.dir"
  if [ -e $file ]; then 
    dir=$(<"$file")
  else
    dir=$(pwd)
  fi
  if [[ $dir =~ /$ ]]; then
    dir=${dir%/*}
  fi
  dest=$1
  dest=${dest%\(cutted\)}
  dest=${dest%\(yanked\)}
  if [ $dest = "." ]; then 
    dir=${dir}
  elif [ $dest = ".." ]; then 
    dir=${dir%/*}
    if [[ $dir = "" ]]; then
      dir="/"
    elif [[ $dir = "." ]]; then
      dir=$(pwd)
    fi
  elif [[ $dest =~ ^/ ]]; then
    dir=$dest
  elif [[ -d "$dir/$dest" ]]; then
    dir="$dir/$dest"
  elif [[ -d $dest ]]; then
    dir="$dir/$dest"
  else
    dir=${dest%/*}
    if [[ $dir = "" ]]; then
      dir="/"
    elif [[ $dir = "." ]]; then
      dir=$(pwd)
    fi
  fi
  if [ $dir = "/" ]; then
  else
    if [[ $dir =~ /$ ]]; then
      dir=${dir%/*}
    fi
  fi
  if [ -d "$dir" ]; then
    # cleanup search when enter a folder
    search_file="/tmp/fm.search.result"
    if [ -e $search_file ]; then
      rm $search_file
    fi
    echo $dir > $file
  fi
}

fm_cp_file() {
  if [ -z $1 ]; then
    return
  fi
  file="/tmp/fm.dir"
  if [ -e $file ]; then 
    dir=$(<"$file")
  else
    dir=$(pwd)
  fi
  nfile="$dir/$1"
  echo "duplicate $nfile, please enter new name:"
  read dest
  read -r directory dest <<< "$(fm_mk_dest_dir $dest)"
  echo $directory > $file
  cp -v -i -r $nfile $dest
}

fm_mv_file() {
  if [ -z $1 ]; then
    return
  fi
  file="/tmp/fm.dir"
  if [ -e $file ]; then 
    dir=$(<"$file")
  else
    dir=$(pwd)
  fi
  nfile="$dir/$1"
  echo "rename $nfile, please enter new name:"
  read dest
  read -r directory dest <<< "$(fm_mk_dest_dir $dest)"
  echo $directory > $file
  mv -i $nfile $dest
}

fm_rm_file() {
  if [ -z $1 ]; then
    return
  fi
  file="/tmp/fm.dir"
  if [ -e $file ]; then 
    dir=$(<"$file")
  else
    dir=$(pwd)
  fi
  dest="$dir/$1"
  rm -i -r $dest
}

fm_mk_dest_dir() {
  file="/tmp/fm.dir"
  $dest = $1
  if [[ $dest =~ ^/ ]]; then
  else
    if [ -e $file ]; then 
      directory=$(<"$file")
    else
      directory=$(pwd)
    fi
    dest=$directory/$dest
  fi
  if [[ $dest == *"/"* ]]; then
    directory=${dest%/*}
  fi
  if [ $directory = ""]; then
    directory="/"
  else
    if [ -d "$directory" ]; then
    else
      mkdir -p $directory
    fi
  fi
  echo $directory $dest
}


fm_new_file() {
  file="/tmp/fm.dir"
  echo "New file, please enter name, path should end with /:"
  read dest
  read -r dir dest <<< "$(fm_mk_dest_dir $dest)"
  echo $dir
  echo $dest
  if [[ $dest =~ /$ ]]; then
    mkdir -p $dest
    dir=${dest%/*}
    echo $dir > $file
  else
    echo $dir > $file
    touch $dest
  fi
}


fm_remove_file_from_list() {
  file="/tmp/fm.dir"
  dest=$1
  dest=${dest%\(cutted\)}
  dest=${dest%\(yanked\)}
  if [[ $dest =~ ^/ ]]; then
  else
    if [ -e $file ]; then 
      directory=$(<"$file")
    else
      directory=$(pwd)
    fi
    dest=$directory/$dest
  fi
  if [[ $dest =~ /$ ]]; then
    dest=${dest%/*}
  fi
  file_list=$2
  files=()
  while IFS= read -r line; do
    files+=("$line")
  done < $file_list
  rm $file_list
  for c in "${files[@]}"; do
    if [ "$dest" != "$c" ]; then
        if [ -e $file_list ]; then 
          echo $c >> $file_list
        else
          echo $c > $file_list
        fi
    fi
  done
}

fm_uncut_file() {
  cut_list="/tmp/fm.dir.cut"
  fm_remove_file_from_list $1 $cut_list
}

fm_unyank_file() {
  yank_list="/tmp/fm.dir.yank"
  fm_remove_file_from_list $1 $yank_list
}

fm_add_file_into_list() {
  file="/tmp/fm.dir"
  dest=$1
  file_list=$2
  dest=${dest%\(cutted\)}
  dest=${dest%\(yanked\)}
    echo $dest
  if [[ $dest =~ ^/ ]]; then
  else
    if [ -e $file ]; then 
      directory=$(<"$file")
    else
      directory=$(pwd)
    fi
    dest=$directory/$dest
  fi
  if [[ $dest =~ /$ ]]; then
    dest=${dest%/*}
  fi
    echo $dest
  # files=($(cat $file_list))
  # files=("${files[@]}")
  files=()
  while IFS= read -r line; do
    files+=("$line")
  done < $file_list
  found='0'
  for c in "${files[@]}"; do
    if [ "$dest" = "$c" ]; then
      found='1'
      break
    fi
  done
  if [ $found = '0' ]; then
    if [ -e $file_list ]; then 
      echo $dest >> $file_list
    else
      echo $dest > $file_list
    fi
  fi
}

fm_yank_files() {
  files=("$@")
  for f in "${files[@]}"; do
    fm_yank_file $f
  done
}
fm_yank_file() {
  if [ -z $1 ]; then
    return
  fi
  yank_list="/tmp/fm.dir.yank"
  if [[ $1 == *'(yanked)' ]]; then
    fm_unyank_file $1
  else
    if [[ $1 == *'(cutted)' ]]; then
      fm_uncut_file $1
    fi
    fm_add_file_into_list $1 $yank_list
  fi
}

fm_cut_files() {
  files=("$@")
  for f in "${files[@]}"; do
    fm_cut_file $f
  done
}
fm_cut_file() {
  if [ -z $1 ]; then
    return
  fi
  cut_list="/tmp/fm.dir.cut"
  if [[ $1 == *'(cutted)' ]]; then
    fm_uncut_file $1
  else
    if [[ $1 == *'(yanked)' ]]; then
      fm_unyank_file $1
    fi
    fm_add_file_into_list $1 $cut_list
  fi
}

fm_paste_file() {
  file="/tmp/fm.dir"
  if [ -e $file ]; then 
    directory=$(<"$file")
  else
    directory=$(pwd)
  fi
  directory="$directory/"

  yank_list="/tmp/fm.dir.yank"
  if [ -e $yank_list ]; then 
    while IFS= read -r file
    do
      if [ -e $file ]; then 
        # last_element="${my_string##*/}"
        echo "cp -v -i -r $file $directory"
        cp -v -i -r $file $directory
      fi
    done < $yank_list
    echo "" > $yank_list
  fi

  cut_list="/tmp/fm.dir.cut"
  if [ -e $cut_list ]; then 
    while IFS= read -r file
    do
      if [ -e $file ]; then 
        # last_element="${my_string##*/}"
        echo "mv -i -v $file $directory"
        mv -i -v $file $directory
      fi
    done < $cut_list
    echo "" > $cut_list 
  fi
}
