
custom_user_setup() {
    # TODO:
    # custom code to set up services, routes, etc.
    return
}

print_settings() {
    echo api          : $CF_API
    echo user         : $CF_USER
    echo organization : $CF_ORG
    echo space        : $CF_SPACE
    echo application  : $CF_APP
    echo pushargs     : $CF_PUSHARGS
}

while [ $# -gt 0 ]
do
    case $1 in
        "-a" | "--api")
            CF_API=$2
            shift
            shift
            ;;
        "-u" | "--user")
            CF_USER=$2
            shift
            shift
            ;;
        "-p" | "--password")
            CF_PASSWORD=$2
            shift
            shift
            ;;
        "-o" | "--org")
            CF_ORG=$2
            shift
            shift
            ;;
        "-s" | "--space")
            CF_SPACE=$2
            shift
            shift
            ;;
        "-n" | "--app")
            CF_APP=$2
            shift
            shift
            ;;
        "--pushargs")
            CF_PUSHARGS=$2
            shift
            shift
            ;;
        "--settings")
            do_print_settings=1
            shift
            ;;
        *)
            echo "unrecognised arg $1"
            exit
            ;;
    esac
done

fail() {
    echo $*
    exit 1
}

export CF_COLOR=false
CF=cf

if (test -n "$do_print_settings" )
then
    print_settings
    exit 0
fi

# setup 
$CF api $CF_API || fail "Error setting api endpoint: $CF_API"
$CF auth $CF_USER $CF_PASSWORD 1> /dev/null || fail "Error authenticating $CF_USER"
$CF target -o $CF_ORG -s $CF_SPACE || fail "Error setting org: $CF_ORG and space: $CF_SPACE"

# user setup
custom_user_setup

# push
$CF push $CF_APP $CF_PUSHARGS || fail "Error pushing application $CF_APP"

$CF logout

