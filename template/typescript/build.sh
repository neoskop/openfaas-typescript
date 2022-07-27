if [ "$DEBUG" = "true" ]; then
    echo "Debug Mode: Skip build"
else
    ./node_modules/typescript/bin/tsc --project ./function
    ./node_modules/typescript/bin/tsc 
fi