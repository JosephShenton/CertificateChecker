for p in $(find certificates -name "*.p12"); do 
  password=$(basename $p);
  password="${password%.*}"
  ./request.sh "$p" "$password";
done