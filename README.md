# shrimp-oo : shell script package for object oriented programming.

---
https://travis-ci.org/a9210/shrimp-oo.svg?branch=develop

*** Currently It works on only bash. *** Because It uses ${BASH_PID}.
# use with shrimp

We also lunch package manager for shell scripts.
Please check it out at https://github.com/a9210/shrimp.

## How to use

### make project

```
shrimp create myOoApp
cd myOoApp
shrimp install shrimp-oo https://github.com/a9210/shrimp-oo
shrimp install shrimp-util https://github.com/a9210/shrimp-util
```

### create object

**myOoApp.sh**
```shell
#!/bin/bash
source @import.sh
source $(@import shrimp-oo shrimp-oo.sh)

Hash=$(@import shrimp-util Hash.sh)

rushHash=$(@new ${Hash})
@invoke ${rushHash}.put "vocal" "Geddy Lee"
@invoke ${rushHash}.put "bass" "Geddy Lee"
@invoke ${rushHash}.put "guiter" "Alex Lifeson"
@invoke ${rushHash}.put "drums" "Neil Peart"

yuraHash=$(@new ${Hash})
@invoke ${yuraHash}.put "vocal" "SAKAMOTO Shintaro"
@invoke ${yuraHash}.put "bass" "KAMEKAWA Chiyo"
@invoke ${yuraHash}.put "guiter" "SAKAMOTO Shintaro"
@invoke ${yuraHash}.put "drums" "SHIBATA Ichiro"

@invoke ${rushHash}.get "vocal"
@invoke ${rushHash}.get "bass"

@invoke ${yuraHash}.get "vocal"
@invoke ${yuraHash}.get "bass"

@delete ${rushHash}
@delete ${yuraHash}
```
YOU MAY REPLACE BANDS WITH YOUR FAVARIT ONE.

myOoApp.sh will show ...

```
Geddy Lee
Geddy Lee
SAKAMOTO Shintaro
KAMEKAWA Chiyo
```