#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m'
testsPassed=true
clear
printf "${PURPLE}CHECK LINTING...${NC}\n"
{ # Check Linting for all servers
  if ( cd KA-VR ; npm run lint &>../error.log) then
    printf "${GREEN}✓ Linting Passed: KA-VR${NC}\n"
  else
    printf "${RED}✗ Linting Failed: KA-VR${NC}\n"
    testsPassed=false
  fi
} && {
  if ( cd textAnalyzer ; npm run lint &>../error.log) then
    printf "${GREEN}✓ Linting Passed: textAnalyzer${NC}\n"
  else
    printf "${RED}✗ Linting Failed: textAnalyzer${NC}\n"
    testsPassed=false
  fi
} && {
  if ( cd brainml ; npm run lint &>../error.log) then
    printf "${GREEN}✓ Linting Passed: brainml${NC}\n"
  else
    printf "${RED}✗ Linting Failed: brainml${NC}\n"
    testsPassed=false
  fi
} && {
  if ( cd apiserver ; npm run lint &>../error.log) then
    printf "${GREEN}✓ Linting Passed: apiserver${NC}\n"
  else
    printf "${RED}✗ Linting Failed: apiserver${NC}\n"
    testsPassed=false
  fi
} && { # Start Servers
  if [ "$testsPassed" = true ] ; then
    printf "${GREEN}✌ Starting Servers...${NC}\n"
    ( cd KA-VR ; npm run watch-server | npm run dev-server | npm run watch-client &>../server.kavr.log) & \
    ( cd textAnalyzer ; npm start &>../server.text.log) & \
    ( cd brainml ; npm start &>../server.brain.log)
    ( cd apiserver ; npm start &>../server.api.log)
  fi
}