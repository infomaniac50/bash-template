#!/bin/bash

(
cat <<ENDOFSTRING
#!/bin/bash

# Keep the trailing slashes consistent
# if you want rsync to upload to the right place.

# if find_in_ancestor "rsync-exclude.txt"; then
    # Extra rsync arguments
    # export extra_=--exclude-from="\$found_in_ancestor"

    # Local Project Directory
    export local_='src/'

    # Remote Project Directory
    remote_='<username>@<hostname>:<remote directory>/'
# fi
ENDOFSTRING
) > .coder
