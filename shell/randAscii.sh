#!/bin/bash

case $[($RANDOM % 15)  + 1] in
  1)
    ack --bar 
    ;;
  2)
    ack --cathy
    ;;
  3)
    ack --thppt
    ;;
  4)
    cat ~/dotfiles/ascii/code_clean
    ;;
  5)
    cat ~/dotfiles/ascii/dragon1
    ;;
  6)
    cat ~/dotfiles/ascii/dragon2
    ;;
  7)
    cat ~/dotfiles/ascii/dragon3
    ;;
  8)
    cat ~/dotfiles/ascii/unicorn
    ;;
  9)
    cat ~/dotfiles/ascii/atom
    ;;
  10)
    cat ~/dotfiles/ascii/cakelie
    ;;
  11)
    cat ~/dotfiles/ascii/honeybee
    ;;
  12) 
    cat ~/dotfiles/ascii/kill
    ;;
  13)
    cat ~/dotfiles/ascii/unicorn2
    ;;
  14) 
    cat ~/dotfiles/ascii/yoda
    ;;
  15) 
    cat ~/dotfiles/ascii/nemisys

esac


