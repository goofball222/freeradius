* **2021-06-18:**
    * Switch to GitHub actions for builds
    * Update freeradius version to 3.0.23
    * Update documentation
    * Update default config files to 3.0.23 version
---
* **2020-05-12:**
    * Update README to reflect current freeradius version
    * Update authorize, and radiusd.conf to match 3.0.20 default versions
---
* **2019-06-28:**
    * Update README to reflect current freeradius version
    * Update authorize, and radiusd.conf to match 3.0.19 default versions
---
* **2018-08-24:**
    * Add tzdata package to fix localtime/TZ issue
    * Update docker-entrypoint.sh, change LOGDIR to LOGFILE
    * Update build hook script
    * Extremely minor update to docs
    * Shh, be vewy vewy quiet, I'm hunting errors in the build logs. (Add -q to Dockerfile apk commands)
---
* **2018-08-19:**
    * Initial Dockerfile, script, etc. creation.
