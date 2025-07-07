#!/bin/bash

# PantherX - Offensive Toolkit 🐾
# Version: 1.1

# Color definitions
GREEN='\033[1;32m'
NC='\033[0m'

# Logo
print_logo() {
echo -e "${GREEN}"
echo "    ____                __  __           __  __ "
echo "   / __ \____  ___     \ \/ /___  __  __/ /_/ /_"
echo "  / /_/ / __ \/ _ \     \  / __ \/ / / / __/ __/"
echo " / ____/ /_/ /  __/     / / /_/ / /_/ / /_/ /_  "
echo "/_/    \____/\___/     /_/\____/\__,_/\__/\__/  "
echo -e "        PantherX Offensive Toolkit 🐾 v1.1"
echo -e "        Author: wtshex1"
echo -e "        License: Educational & Ethical Use Only${NC}\n"
}

# Tool status check
tool_status() {
  command -v "$1" &> /dev/null
  return $?
}

# Tool check symbol
tool_check_symbol() {
  if tool_status "$1"; then
    echo -e "${GREEN}[✔]${NC}"
  else
    echo -e "${GREEN}[✘]${NC}"
  fi
}

# Show main menu
show_menu() {
  print_logo
  echo -e "${GREEN}+----------------------------------------------+"
  printf "| %-44s |\n" "1) Nmap Scan        $(tool_check_symbol nmap)"
  printf "| %-44s |\n" "2) Hydra Bruteforce $(tool_check_symbol hydra)"
  printf "| %-44s |\n" "3) SQLMap Injection $(tool_check_symbol sqlmap)"
  printf "| %-44s |\n" "4) Metasploit       $(tool_check_symbol msfconsole)"
  printf "| %-44s |\n" "5) John the Ripper  $(tool_check_symbol john)"
  printf "| %-44s |\n" "6) Aircrack-ng      $(tool_check_symbol aircrack-ng)"
  printf "| %-44s |\n" "7) Netcat           $(tool_check_symbol nc)"
  printf "| %-44s |\n" "8) NetExec          $(tool_check_symbol nxc)"
  printf "| %-44s |\n" "9) Custom Command"
  printf "| %-44s |\n" "0) Exit PantherX"
  echo -e "+----------------------------------------------+${NC}"
}

# Execute tool
run_tool() {
  while true; do
    case $1 in
      1)
        tool_status nmap || { echo -e "${GREEN}Nmap not available.${NC}"; return; }
        read -p $'\033[1;32mEnter target IP/domain: \033[0m' target
        nmap -A "$target"
        ;;
      2)
        tool_status hydra || { echo -e "${GREEN}Hydra not available.${NC}"; return; }
        read -p $'\033[1;32mService (ftp/ssh/etc.): \033[0m' service
        read -p $'\033[1;32mTarget IP: \033[0m' target
        read -p $'\033[1;32mUsername list path: \033[0m' userlist
        read -p $'\033[1;32mPassword list path: \033[0m' passlist
        hydra -L "$userlist" -P "$passlist" "$target" "$service"
        ;;
      3)
        tool_status sqlmap || { echo -e "${GREEN}SQLMap not available.${NC}"; return; }
        read -p $'\033[1;32mTarget URL: \033[0m' url
        sqlmap -u "$url" --batch --dbs
        ;;
      4)
        tool_status msfconsole || { echo -e "${GREEN}Metasploit not available.${NC}"; return; }
        msfconsole
        ;;
      5)
        tool_status john || { echo -e "${GREEN}John the Ripper not available.${NC}"; return; }
        read -p $'\033[1;32mHash file path: \033[0m' hashfile
        john "$hashfile"
        ;;
      6)
        tool_status aircrack-ng || { echo -e "${GREEN}Aircrack-ng not available.${NC}"; return; }
        read -p $'\033[1;32m.cap file path: \033[0m' capfile
        read -p $'\033[1;32mWordlist path: \033[0m' wordlist
        aircrack-ng "$capfile" -w "$wordlist"
        ;;
      7)
        tool_status nc || { echo -e "${GREEN}Netcat not available.${NC}"; return; }
        read -p $'\033[1;32mNetcat command: \033[0m' nccommand
        bash -c "$nccommand"
        ;;
      8)
        tool_status nxc || { echo -e "${GREEN}NetExec not available.${NC}"; return; }
        read -p $'\033[1;32mNetExec command: \033[0m' necommand
        bash -c "$necommand"
        ;;
      9)
        read -p $'\033[1;32mCustom command: \033[0m' custom
        bash -c "$custom"
        ;;
      0)
        echo -e "${GREEN}Exiting PantherX. Stay sharp!${NC}"
        exit 0
        ;;
      *)
        echo -e "${GREEN}Invalid option.${NC}"
        return
        ;;
    esac

    echo -e "\n${GREEN}✓ Tool executed."
    echo -e "What do you want to do next?"
    echo -e "[1] Return to main menu"
    echo -e "[2] Run this tool again"
    echo -e "[3] Exit PantherX${NC}"
    read -p $'\033[1;32mChoice: \033[0m' choice

    case $choice in
      1) break ;;
      2) continue ;;
      3)
        echo -e "${GREEN}Goodbye, bro!${NC}"
        exit 0
        ;;
      *)
        echo -e "${GREEN}Invalid choice. Back to menu.${NC}"
        break
        ;;
    esac
  done
}

# Main loop
while true; do
  clear
  show_menu
  echo ""
  read -p $'\033[1;32mChoose an option: \033[0m' option
  clear
  run_tool "$option"
done

