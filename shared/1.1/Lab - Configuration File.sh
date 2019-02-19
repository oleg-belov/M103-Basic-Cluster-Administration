#!/bin/sh

# ============================================================================== #
# MIT License                                                                    #
#                                                                                #
# Copyright (c) 2019 Oleg Belov                                                  #
#                                                                                #
# Permission is hereby granted, free of charge, to any person obtaining a copy   #
# of this software and associated documentation files (the "Software"), to deal  #
# in the Software without restriction, including without limitation the rights   #
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      #
# copies of the Software, and to permit persons to whom the Software is          #
# furnished to do so, subject to the following conditions:                       #
#                                                                                #
# The above copyright notice and this permission notice shall be included in     #
# all copies or substantial portions of the Software.                            #
#                                                                                #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  #
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  #
# SOFTWARE.                                                                      #
# ============================================================================== #
#                                                                                #
# DESCRIPTION : Solution for M103-Basic-Cluster-Administration's Lab 2.          #
# AUTHOR : Oleg Belov                                                            #
# COPYRIGHT : Copyright (c) 2019 Oleg Belov                                      #
# LICENSE : MIT                                                                  #
#                                                                                #
# ============================================================================== #

# Print start status message.
CURRENT_DATE=$(date)
echo Start: ${CURRENT_DATE}

# Kills all the mongo process and waits for them to exit.
pkill mongod
sleep 3

# Start the server
mongod -f ./mongod.conf

# Create admin user & hide the output
mongo admin --host localhost:27000 --eval '
  db.createUser({
    user: "m103-admin",
    pwd: "m103-pass",
    roles: [
      {role: "root", db: "admin"}
    ]
  })' >&- 2>&-

echo "Admin user is created!"

# Run Test
RESULT=$(validate_lab_configuration_file)

# Print the result
echo "The reult of the test = ${RESULT}"