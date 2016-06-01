#!/bin/bash

(
cat <<ENDOFSTRING
#!/bin/bash

# Keep the trailing slashes consistent
# if you want rsync to upload to the right place.

# Extra rsync arguments
# extra_=""

# Local Project Directory
local_='src/'

# Remote Project Directory
remote_='<username>@<hostname>:<remote directory>/'
ENDOFSTRING
) > .coder
