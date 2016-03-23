# Copyright 2014 The Oppia Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS-IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

##########################################################################

# This file should not be invoked directly, but sourced from other sh scripts.
# Bash execution environment setup for scripts that require GAE.


if [ "$SETUP_GAE_DONE" ]; then
  return 0
fi

export GOOGLE_APP_ENGINE_HOME=$TOOLS_DIR/google_appengine_1.9.19/google_appengine
export COVERAGE_HOME=$TOOLS_DIR/coverage-4.0

# Note that if the following line is changed so that it uses webob_1_1_1, PUT requests from the frontend fail.
export PYTHONPATH=.:$COVERAGE_HOME:$GOOGLE_APP_ENGINE_HOME:$GOOGLE_APP_ENGINE_HOME/lib/webob_0_9:$TOOLS_DIR/webtest-1.4.2:$PYTHONPATH

# Delete old *.pyc files
find . -iname "*.pyc" -exec rm -f {} \;

echo Exported paths for Google App Engine, checking if it needs to be installed.
if [ ! -d "$GOOGLE_APP_ENGINE_HOME" ]; then
	mkdir -p $GOOGLE_APP_ENGINE_HOME
	curl --silent https://storage.googleapis.com/appengine-sdks/deprecated/1919/google_appengine_1.9.19.zip -o gae-download.zip
	unzip -qq gae-download.zip -d $TOOLS_DIR/google_appengine_1.9.19/
	rm gae-download.zip
else
	echo Google App Engine folder detected.
fi

export SETUP_GAE_DONE=true
