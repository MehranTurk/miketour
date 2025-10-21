# 🌐 Mikrotik Login Tester

**Author:** [MehranTurk (M.T)](https://github.com/MehranTurk)  
**License:** MIT License  
**Version:** 1.0  

---

## 🧩 Overview

**Mikrotik Login Tester** is a **Bash script** designed to test login credentials on **Mikrotik routers**.  
It simulates JavaScript-style login forms to automatically test password lists against the router.

---

## ⚙️ Example Usage

```bash
./miketour.sh 192.168.88.1 admin /usr/share/wordlists/rockyou.txt
```

---

## Parameters

- 🖥️ **target_ip** → Target router IP address
- 👤 **username** → Username to test
- 📂 **wordlist** → Path to the password wordlist file

---

## 📦 Requirements

To run this script properly, you need:

- **Bash shell**
- **curl** (for sending requests)
- **Wordlist** (password file for testing)

---

## 🛠️ Installation

### 🔧 Dependencies Installation

#### 🐧 Ubuntu / Debian

```bash
sudo apt update && sudo apt install curl
```

#### 🔴 CentOS / RHEL

```bash
sudo yum install curl
```

---

## 📤 Output

The script provides **real-time feedback** while running:

| Color | Description |
|--------|-------------|
| 🟢 **Green** | Successful login (valid password) |
| 🔴 **Red** | Failed attempt |
| 🔵 **Blue** | Informational message |
| 🟡 **Yellow** | Warnings or usage info |

📝 **Valid credentials** are saved in the file `valid_logins.txt`:

```
username:password
```

---

## ⚠️ Disclaimer

This tool is intended **only for the following purposes:**

- 🔐 Security testing on your own devices
- 🎓 Educational purposes
- 🧑‍💻 Authorized penetration testing
- 🧱 Network security assessments

❗ Please **only use this tool on networks and devices you own or have explicit permission to test.**

---

## 📜 License

This project is released under the **MIT License**.  
You are free to use, modify, and distribute it.

---

## 💰 Donate

If this tool was helpful, you can support its development ❤️

| Currency | Address |
|-----------|----------|
| **USDT / TRX** | `TSVd8USqUv1B1dz6Hw3bUCQhLkSz1cLE1v` |
| **BTC** | `32Sxd8UJav7pERtL9QbAStWuFJ4aMHaZ9g` |
| **ETH** | `0xb2ba6B8CbB433Cb7120127474aEF3B1281C796a6` |

---

© 2025 **MehranTurk** — All rights reserved.
