#!/bin/bash

swift build --configuration release

swift run HelpMeCountServer serve --env production --port 8081 --hostname 0.0.0.0
