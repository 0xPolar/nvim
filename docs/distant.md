# distant.nvim — Quickstart

Remote editing over SSH from Neovim.
Config lives in:

- `lua/plugins/distant.lua` — plugin spec
- `lua/config/distant-hosts.lua` — host list + keybinds

---

## Keybinds

| Keybind      | Action                                                                 |
| ------------ | ---------------------------------------------------------------------- |
| `<leader>rc` | Connect to a remote host (picker), then auto-open `/home`              |
| `<leader>rb` | Browse an arbitrary remote directory on the active connection         |
| `<leader>rt` | Open a terminal/shell on the active remote connection                  |

Inside a remote buffer/dir, standard Neovim/LazyVim keys work:
`gd`, `<leader>ff`, `:w`, etc. distant transparently proxies file I/O.

---

## Adding a new host

Edit `lua/config/distant-hosts.lua` and append an entry to the `hosts` table.

### SSH key auth

```lua
{
  name = "My New Box",
  destination = "user@192.168.1.42:22",
  auth = "key",
  key = "~/.ssh/id_ed25519_mybox",
},
```

### Password auth

```lua
{
  name = "Legacy Server",
  destination = "user@legacy.example.com:22",
  auth = "password",
},
```

(You'll be prompted for the password during connect.)

### Docker dev box

Two patterns — pick based on your container setup.

**Pattern A — sshd inside the container (simplest, works with the current config):**

1. In your `docker-compose.yml` or `Dockerfile`, expose port 22 and run `sshd`:

   ```yaml
   services:
     devbox:
       image: my-devbox:latest
       ports:
         - "2222:22"
       volumes:
         - ~/.ssh/id_ed25519_devbox.pub:/root/.ssh/authorized_keys:ro
   ```

2. Add a host entry pointing at the mapped port:

   ```lua
   {
     name = "Docker Dev Box",
     destination = "root@localhost:2222",
     auth = "key",
     key = "~/.ssh/id_ed25519_devbox",
   },
   ```

3. First time only — trust the container's host keys:

   ```bash
   ssh-keyscan -t rsa,ecdsa,ed25519 -p 2222 localhost >> ~/.ssh/known_hosts
   ```

**Pattern B — SSH to the Docker host, then connect to the container path:**

Add the Docker host (not the container) as a regular SSH host, then open the
bind-mounted project dir. Simplest if your workflow is "edit files on host,
container just runs them."

---

## First-time host setup (new machine or rebuilt)

After adding a host entry, trust the new host keys **once**:

```bash
# Replace IP/hostname as needed
ssh-keyscan -t rsa,ecdsa,ed25519 <host-or-ip> >> ~/.ssh/known_hosts
```

> Grab all three key types — distant's ssh2 library often negotiates ECDSA
> or RSA rather than ED25519, and `known_hosts` needs the matching type.

If a host was **rebuilt** and keys changed, purge the stale entry first:

```bash
ssh-keygen -R <host-or-ip>
```

Then re-run the `ssh-keyscan` above.

Sanity check the key from a terminal before connecting in Neovim:

```bash
ssh -i ~/.ssh/id_ed25519_<key> user@host
```

---

## Daily usage

1. `<leader>fR` → pick host from the list.
2. Wait for `Connected to <name>` notification. `/home` opens automatically.
3. `<leader>fE` to browse to any other directory on the active connection.
4. Open files, edit, save — all proxied over SSH.

---

## Troubleshooting

Logs (Windows):

- `~/AppData/Local/distant/cache/client.log` — per-client errors, SSH handshake
- `~/AppData/Local/distant/cache/manager.log` — manager daemon state

Linux/macOS equivalent: `~/.cache/distant/`.

Common errors:

| Error                              | Cause                                    | Fix                                                  |
| ---------------------------------- | ---------------------------------------- | ---------------------------------------------------- |
| `Unable to detect binary version`  | `distant` binary is wrong version        | Install v0.20.0 binary (v0.3 plugin pins to 0.20.x) |
| `host verification: host key mismatch` | Host was rebuilt / missing key type      | `ssh-keygen -R <host>` then re-run `ssh-keyscan`    |
| `No active connection!`            | `DistantOpen` ran before connect finished | Already handled — connect uses async callback        |
| `exited unexpectedly`              | Usually host key mismatch (check logs)   | See log files above                                  |

Binary install path (used by plugin default):

- Windows: `~/AppData/Local/nvim-data/distant.nvim/bin/distant.exe`
- Linux/macOS: `~/.local/share/nvim/distant.nvim/bin/distant`

If you ever need to reinstall: delete the binary and run `:DistantInstall`
in Neovim — but be aware it grabs the **latest** release, which may be newer
than the v0.3 plugin supports. Safer: download v0.20.0 manually from
<https://github.com/chipsenkbeil/distant/releases/tag/v0.20.0>.
