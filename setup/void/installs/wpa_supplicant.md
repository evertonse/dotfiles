
# 📡 Very Simple Guide: Connecting to Wi-Fi with `wpa_supplicant` on Void Linux (Base Install, No Root User)

This guide helps you connect to Wi-Fi using `wpa_supplicant` **after a Void Linux base installation**, assuming you're using **runit** and **no root user is required**.

---

## ✅ 1. Enable and Start `dhcpcd` and `wpa_supplicant` Services

```sh
sudo ln -s /etc/sv/dhcpcd /var/service
sudo ln -s /etc/sv/wpa_supplicant /var/service

sudo sv up dhcpcd
sudo sv up wpa_supplicant
```

---

## 🔍 2. Get Your Wi-Fi Interface Name

```sh
ip link show
```

Look for something like `wlp3s0`, `wlan0`, or `wlp38s0`.

---

## 💬 3. Connect Using `wpa_cli`

Launch `wpa_cli` with your Wi-Fi interface name:

```sh
wpa_cli -i wlp38s0  # Replace with your actual interface
```

Now you're inside the `wpa_cli` shell.

---

## 📶 4. Scan and Connect

Inside the `wpa_cli` interface:

```sh
> scan
> scan_result
> add_network
> set_network 0 ssid "YourNetworkName"
> set_network 0 psk "YourPassword"
> enable_network 0
```

### ⚠️ Notes:

* **Quotes are required** around SSID and password!
* The number `0` refers to the network ID just created.

Example:

```sh
> set_network 0 ssid "MyHomeWiFi"
> set_network 0 psk "supersecret123"
```

Exit `wpa_cli` with:

```sh
Ctrl + C
```

---

## 🌐 5. Test Your Connection

Try:

```sh
ping 8.8.8.8
```

If it works — you're online! 🎉
