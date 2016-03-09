#!/bin/bash

case $[($RANDOM % 11)  + 1] in
  1)
    cat ~/dotfiles/ascii/killbugs
    ;;
  2)
    ack --bar 
    ;;
  3)
    cat ~/dotfiles/ascii/syndicate
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

esac


